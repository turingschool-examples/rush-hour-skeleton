require_relative '../models/unique'
require_relative '../models/payload_creator'
require_relative '../models/response_messages'

module RushHour
  class Server < Sinatra::Base
    include Unique
    include PayloadCreator
    include ResponseMessages

    not_found do
      erb :error
    end

    post '/sources/:identifier/data' do |identifier|
      payload = create_new_payload(params, identifier)
      payload_response_decider(payload)
    end

    post '/sources' do
      client_response_decider
    end
  end
end
