module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      # if valid parsed & not already in database
      source = Source.new(identifier: params[:identifier], root_url: params[:rootUrl])
      if source.save
        status 200
        body ({"identifier" => params[:identifier]}.to_json)
      elsif source.errors.full_messages.join(", ").include?("already been taken")
        status 403
        body source.errors.full_messages.join(", ")
      else
        status 400
        body source.errors.full_messages.join(", ")
      end
    end

    post '/sources/:identifier/data' do
      digest = Digest::SHA2.hexdigest(params.to_s)
      parsed = JSON.parse(params["payload"])

      payload = Payload.new(url: parsed["url"],
                            requested_at: parsed["requestedAt"],
                            responded_in: parsed["respondedIn"],
                            referred_by: parsed["referredBy"],
                            request_type: parsed["requestType"],
                            parameters: parsed["parameters"],
                            event_name: parsed["eventName"],
                            user_agent: parsed["userAgent"],
                            resolution_width: parsed["resolutionWidth"],
                            resolution_height: parsed["resolutionHeight"],
                            ip: parsed["ip"],
                            digest: digest)
    end
  end
end
