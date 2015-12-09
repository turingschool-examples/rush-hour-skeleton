module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      if params[:identifier] && params[:rootUrl]
        user = User.new(identifier: params[:identifier], root_url: params[:rootUrl])
        if user.save
          id = params[:identifier]
          {'identifier' => id}.to_json
        else
          status(403)
          "Identifier already exists."
        end
      else
        status(400)
        "Missing all required details."
      end
    end

    post '/sources/:id/data'  do |id|
      if params[:payload].nil?
        status 400
        body "No payload received in the request"
      else
        p_pams = JSON.parse(params["payload"])
        p_sha = Digest::SHA1.hexdigest(p_pams.to_s)
        identifier = params["id"]
        user = User.find_by(identifier: identifier)
        if user.nil?
          status 403
          body "#{params["id"]} is not registered"
        elsif Payload.find_by(payload_sha: p_sha)
          status 403
          body "This specific payload already exists in the database..."
        else
          ua = UserAgent.parse(p_pams["userAgent"])
          resolution = Resolution.find_or_create_by(dimension: "#{p_pams["resolutionWidth"]} x #{p_pams["resolutionHeight"]}")
          Payload.create(user_id: user.id, resolution_id: resolution.id, url: p_pams["url"], requested_at: p_pams["requestedAt"], responded_in: p_pams["respondedIn"], referred_by: p_pams["referredBy"], request_type: p_pams["requestType"], parameters: p_pams["parameters"], event_name: p_pams["eventName"], user_agent: ua.browser, ip: p_pams["ip"],  payload_sha: p_sha, os: ua.platform)
        end
      end
    end
  end
end
