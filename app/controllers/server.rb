require 'json'
require 'digest'
require 'uri'
require './app/models/json_parser.rb'

module TrafficSpy
  class Server < Sinatra::Base
    attr_accessor :browsers
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

    get "/sources/:identifier/urls/:relative_path" do |identifier, relative_path|
      erb :stats_page
    end

    not_found do
      erb :error
    end
  end
end
