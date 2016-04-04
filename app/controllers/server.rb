require_relative '../models/params_checker'
require_relative '../models/payload_parser'
require_relative '../models/client_parser'

module RushHour
  class Server < Sinatra::Base
    include ParamsChecker
    include PayloadParser
    include ClientParser

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
        erb :not_registered
      elsif @client.payload_requests.count == 0
        erb :no_data
      elsif @client
        @relativepaths = get_relative_paths(@client)
        erb :dashboard
      end
    end

    get '/sources/:identifier/urls/:relativepath' do |identifier, relativepath|
      find_relative_path_payload_requests(identifier, relativepath)
      @requests.count > 0 ? (erb :show) : (erb :not_requested)
    end

    get '/sources/:identifier/events/:eventname' do |identifier, eventname|
      parse_event_data_and_direct_to_page(identifier, eventname)
    end

    get '/sources/:identifier/events' do |identifier|
      get_client_and_events(identifier)
      erb :client_events
    end

    not_found do
      erb :error
    end
  end
end
