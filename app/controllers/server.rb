require_relative '../models/unique'
require_relative '../models/payload_creator'

module RushHour
  class Server < Sinatra::Base
    include Unique
    include PayloadCreator

    not_found do
      erb :error
    end

    post '/sources/:identifier/data' do |identifier|
      payload = create_new_payload(params, identifier)

      if payload_sha_exists?(payload)
        response.status = 403
        response.body = "Payload already exists"
      elsif bad_url?(params)
        response.status = 403
        response.body = "Payload contains URL that doesn't exist"
      else
        if payload.save
          response.status = 200
          response.body = "Payload created"
        else
          response.status = 400
          payload.errors.full_messages.join(", ")
        end
      end
    end

    post '/sources' do
      client_sha = create_sha(params)
      client = Client.new(identifier: params["identifier"], root_url: params["rootUrl"], sha: client_sha)

      if client_sha_exists?(client)
        response.status = 403
        response.body = "Client already exists"
      else
        if client.save
          response.status = 200
          response.body = "Client created"
        else
          response.status = 400
          response.body = client.errors.full_messages.join(", ")
        end
      end
    end

  end
end
