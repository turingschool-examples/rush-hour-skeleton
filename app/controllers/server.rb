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

      if PayloadRequest.find_by(requested_at: payload.requested_at, responded_in: payload.responded_in, resolution_id: payload.resolution_id, system_information_id: payload.system_information_id, referral_id: payload.referral_id, ip_id: payload.ip_id, request_type_id: payload.request_type_id, url_id: payload.url_id, client_id: payload.client_id)
        status 403
        body "403 Forbidden"
      elsif payload.save
        status 200
        body "200 OK"
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
