require 'json'
require 'digest'
require 'uri'
require './app/models/json_parser.rb'

module TrafficSpy
  class Server < Sinatra::Base
    set :show_exceptions, false

    get '/' do
      erb :index
    end

    post '/sources' do
      source = Source.new(:root_url => params[:rootUrl], :identifier => params[:identifier])
      if source.save
        {:identifier => source.identifier}.to_json
      else
        status StatusMessages.status_message(source)

        body source.errors.full_messages.join(", ")
      end
    end

    post '/sources/:identifier/data' do |identifier|

      source = Source.find_by(:identifier => params["identifier"])
      if params["payload"].nil?
        status StatusMessages.blank_payload
        body "payload can't be blank"
      elsif source
        data = JsonParser.parse_json(params["payload"], source)
        if data.save
          body "Created Successfully"
        else
          status StatusMessages.status_message(data)
          body data.errors.full_messages.join(", ")
        end
      else
        status StatusMessages.blank_identifier
        body "Identifier does not exist"
      end
      # status, body = Validator.validate_source(source)
    end

    get "/sources/:identifier" do |identifier|
      counts = Hash.new 0
      @identifier = identifier
      TrafficSpy::Payload.find_each do |payload|
        counts[payload.url_id] += 1
      end
      @max_min_hash = counts.map { |k, v| {TrafficSpy::URL.find(url_id = k).url => v}}

      browser = TrafficSpy::Payload.find_each do |payload|
        @browsers ||= []
        @browsers << UserAgent.parse(TrafficSpy::Agent.find(payload.agent_id).agent).browser
        @browsers.uniq!
      end

      os_breakdown = TrafficSpy::Payload.find_each do |payload|
        @os_breakdown ||= []
        @os_breakdown << UserAgent.parse(TrafficSpy::Agent.find(payload.agent_id).agent).os
        @os_breakdown.uniq!
      end

      resolution = TrafficSpy::Payload.find_each do |payload|
        @resolution ||= []
        @resolution << "#{payload.resolution_width} x #{payload.resolution_height}"
        @resolution.uniq!
      end

      response_time = TrafficSpy::Payload.find_each do |payload|
        @response_time ||= []
        @response_time << payload.responded_in.to_i
        @response_time.sort!.reverse!
      end

      @urls_display = @max_min_hash.map { |hash| hash.keys.pop }
      @paths = @urls_display.map { |url| URI.parse(url).path }

      erb :source_page
    end

    get "/sources/:identifier/url/:relative_paths" do |identifier, relative_paths|
      @referral = Hash.new 0
      @popular_agents = Hash.new 0
      @shortest_response_time = TrafficSpy::Payload.minimum("responded_in").to_f
      @longest_response_time = TrafficSpy::Payload.maximum("responded_in").to_f
      @average_response_time = TrafficSpy::Payload.average("responded_in").to_f
      @http_verbs = TrafficSpy::Payload.find_each do |payload|
        @http_verbs ||= []
        @http_verbs << payload.request_type
        @http_verbs.uniq!
      end
      TrafficSpy::Payload.find_each do |payload|
        @referral[payload.referred_by] += 1
      end
      @top_referral = @referral.max(3)
      TrafficSpy::Payload.find_each do |payload|
        @popular_agents[payload.agent_id] += 1
      end
      @top_agents = @popular_agents.map { |k, v| {TrafficSpy::Agent.find(agent_id = k).agent => v}}
      erb :stats_page
    end

    get "/sources/:identifier/events" do |identifier|
      @identifier = identifier
      events = Payload.group("event_id").count
      @top_events = events.map { |k, v| {TrafficSpy::Event.find(event_id = k).event_name => v}}
      @event_list = @top_events.map {|hash| hash.keys.pop}

      erb :events_index
    end

    get "/sources/:identifier/events/:event_name" do |identifier, event_name|
      erb :event_details
    end


    not_found do
      erb :error
    end
  end
end
