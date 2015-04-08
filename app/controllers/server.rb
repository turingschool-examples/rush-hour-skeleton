require 'json'
require 'byebug'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do 
      source = Source.new(root_url: params["rootUrl"], identifier: params["identifier"])
      if Source.find_by(identifier: source.identifier)
        status 403
        body "Identifier already exists"
      elsif source.save
        status 200
        body JSON.generate({ :identifier => source.identifier })
      else
        status 400
        body source.errors.full_messages
      end
    end

    post '/sources/:identifier/data' do |identifier|
      payload_hash = JSON.parse(params[:payload])
      payload = Payload.new(
        url: payload_hash["url"],
        requested_at: payload_hash["requestedAt"],
        responded_in: payload_hash["respondedIn"],
        referred_by: payload_hash["referredBy"],
        request_type: payload_hash["requestType"],
        parameters: payload_hash["parameters"],
        event_name: payload_hash["eventName"],
        user_agent: payload_hash["userAgent"],
        resolution_width: payload_hash["resolutionWidth"],
        resolution_height: payload_hash["resolutionHeight"],
        id: payload_hash["id"],
        source_id: Source.find_by(identifier: identifier).id 
        )
      if Payload.find_by(requested_at: payload.requested_at) &&
         Payload.find_by(source_id: payload.source_id)
        status 403
        body "Already Received Request"
      elsif payload.save
        status 200
        body "OK"
      else
        status 400
        body "Payload can't be blank"
      end
    end
  end
end
