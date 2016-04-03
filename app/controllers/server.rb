require_relative '../models/params_checker'
require_relative '../models/payload_parser'

module RushHour
  class Server < Sinatra::Base
    include ParamsChecker
    include PayloadParser

    post '/sources' do
      client = Client.new(change_case(params))

      client.save if check(change_case(params))
    end

    post '/sources/:identifier/data' do |identifier|
      result = validate_request(identifier, params)

      add_to_database(params, identifier) if result[0] == 200
      status, body = result
    end

    get '/sources/:identifier' do |identifier|
      @client = Client.find_by(identifier: params['identifier'])
      @identifier = @client.identifier if @client


      if @client == nil
        # USE REDIRECT
        erb :not_registered
      elsif @client.payload_requests.count == 0
        # USE REDIRECT
        erb :no_data
      elsif @client
        urls = @client.most_to_least_frequent_urls
        @urls_with_requests = Hash.new([])
        urls.map do |url|
          @urls_with_requests[url] += @client.find_payload_requests_by_relative_path(url) if @client.find_payload_requests_by_relative_path(url)
        end

        @relativepaths = @urls_with_requests.keys.map { |url| url.split(".com")[1] }
        erb :dashboard
      end
    end

    get '/sources/:identifier/urls/:relativepath' do |identifier, relativepath|
      @client = Client.find_by(identifier: identifier)
      url = "http://#{identifier}.com/#{relativepath}"
      @requests = @client.find_payload_requests_by_relative_path(url)
      # require 'pry'; binding.pry
      erb :show
    end

    get '/sources/:identifier/events/:eventname' do |identifier, eventname| #TODO X, need feature test
      # require 'pry'; binding.pry
      client = Client.find_by(identifier: identifier)

      if client && client.events.find_by(name: eventname)
        event_hours = client.events.find_by(name: eventname).payload_requests.pluck(:requested_at).map do |time|
          Time.parse(time).strftime("%H")
        end

        @events_by_hour = event_hours.inject(Hash.new(0)) { |hash, hour| hash[hour] += 1; hash }
        erb :events
      else
        erb :no_event
      end
    end

    get '/sources/:identifier/events' do |identifier|
      @client = Client.find_by(identifier: identifier)

      @event_names = @client.events.pluck(:name).uniq
      erb :client_events
    end

    not_found do
      erb :error
    end
  end
end
