require 'json'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    get '/sources' do
      erb :sources
    end

    post '/sources' do
      identifier = Identifier.new(name: params[:identifier], root_url: params[:rootUrl])

      if identifier.save
        body "{\"identifier\":\"#{params[:identifier]}\"}"
      else
        error_message = identifier.errors.full_messages.join(" ")
        status_number, message = MessageHelper.send_message(error_message)
        status status_number
        body message
      end
    end

    post '/sources/:identifier/data' do |identifier|
      unless Identifier.exists?(name: identifier)
        return status(403), body("403 Forbidden - Application URL not registered")
      end

      unless params[:payload]
        return status(400), body("Missing Payload - 400 Bad Request")
      end

      payload_hash = JSON.parse(params[:payload])

      if Ip.exists?(address: payload_hash["ip"]) && Payload.exists?(requested_at: payload_hash["requestedAt"])
        return status(403), body("403 Forbidden - Payload Exists")
      end

      PayloadHelper.add_to_specific_tables(payload_hash)
      payload = PayloadHelper.add_payload_data(payload_hash)
      Identifier.where(name: identifier).to_a[0].update(payload_id: payload.id)
      status(200)
    end

    get '/sources/jumpstartlab/events' do
      erb :events
    end

    not_found do
      erb :error
    end

  end
end
