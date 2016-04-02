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
      # require 'pry'; binding.pry
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
          @urls_with_requests[url] += @client.find_payload_requests_by_relative_path(url)
        end

        @relativepaths = @urls_with_requests.keys.map { |url| url.split(".com")[1] }
        erb :dashboard
      end
    end

    get '/sources/:identifier/urls/:relativepath' do |identifier, relativepath|
      @client = Client.find_by(identifier: identifier)
      url = "http://#{identifier}.com/#{relativepath}"
      @requests = @client.find_payload_requests_by_relative_path(url)
      erb :show
    end

    not_found do
      erb :error
    end
  end
end
