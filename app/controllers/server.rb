require 'pry'
module RushHour
  class Server < Sinatra::Base
    post '/sources' do
      parsed_client_attributes = IdentifierParser.new(params).parse

      client = Client.new(parsed_client_attributes)
      if client.save
        status 200
        body "{\"identifier\": \"#{client.identifier}\"}"
      elsif client.errors.full_messages.include?("Root url has already been taken") or client.errors.full_messages.include?("Identifier has already been taken")
        status 403
        body client.errors.full_messages.join(',')
      else
        status 400
        body client.errors.full_messages.join(', ')
      end
    end

    post '/sources/:identifier/data' do |identifier|
      parsed_payload_attributes = PayloadParser.new(params).parse
      payload = PayloadPopulator.populate(parsed_payload_attributes, identifier)

      if payload.save
        status 200
        body "200 OK"
      elsif payload.errors.full_messages.any? do |message|
          message.include?("already")
        end
        status 403
        body "403 Forbidden"
      else
        status 400
        body "400 Bad Request"
      end
    end

    not_found do
      erb :error
    end
  end
end
