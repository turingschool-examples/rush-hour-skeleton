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

      if payload_sha_exists?(payload)
        response_payload_already_exists
      elsif bad_url?(params)
        response_payload_contains_bad_url
      else
        if payload.save
          response_payload_created
        else
          response_list_all_payload_errors
        end
      end
    end

    post '/sources' do
      client_sha = create_sha(params)
      if client_sha_exists?(client)
        response_client_already_exists
      else
        if client.save
          response_client_created
        else
          response_list_all_client_errors
        end
      end
    end
  end
end
