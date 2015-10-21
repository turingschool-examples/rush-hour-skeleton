module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      # if valid params & not already in database
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
      payload = Payload.new(url: params[:url],
                            requested_at: params[:requestedAt],
                            requested_in: params[:requestedIn],
                            referred_by: params[:referredBy],
                            request_type: params[:requestType],
                            parameters: params[:parameters],
                            event_name: params[:eventName],
                            user_agent: params[:userAgent],
                            resolution_width: params[:resolutionWidth],
                            resolution_height: params[:resolution_height],
                            ip: params[:ip],
                            digest: digest)

      binding.pry
    end


  end
end
