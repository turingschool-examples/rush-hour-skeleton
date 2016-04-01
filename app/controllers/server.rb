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

    not_found do
      erb :error
    end
  end
end
