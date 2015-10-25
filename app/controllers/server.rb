require 'json'
require 'digest'
require 'uri'
require 'tilt/erb'
require './app/models/json_parser.rb'
require './app/models/url_data.rb'

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
    end

    get "/sources/:identifier" do |identifier|
      @max_min_hash = UrlData.find_min_max(TrafficSpy::Payload, TrafficSpy::URL)
      @os_breakdown = UrlData.breakdown_os(TrafficSpy::Payload, TrafficSpy::Agent)
      @browsers = UrlData.find_browser_data(TrafficSpy::Payload, TrafficSpy::Agent)
      @resolution = UrlData.find_resolution(TrafficSpy::Payload)
      @response_time = UrlData.find_response(TrafficSpy::Payload)
      @urls_display = @max_min_hash.map { |hash| hash.keys.pop }
      @paths = @urls_display.map { |url| URI.parse(url).path }
      @identifier = identifier
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
      events = Payload.group("event_id").count
      @top_events = events.map { |k, v| {TrafficSpy::Event.find(event_id = k).event_name => v}}
      @event_list = @top_events.map {|hash| hash.keys.pop}
      @identifier = identifier

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
