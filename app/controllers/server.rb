module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    def parse_client_params(params)
      client = Client.new(identifier: params[:identifier],
                          root_url:   params[:rootUrl])

      if client.save
        status_message(200, { identifier: client.identifier }.to_json)
      elsif client.errors.full_messages.first == "Identifier has already been taken"
        status_message(403, "403 Forbidden - Identifier already exists")
      else
        status_message(400, "400 Bad Request - #{client.errors.full_messages.join(", ")}")
      end
    end

    def find_client(identifier)
      Client.find_by(identifier: identifier)
    end

    def status_message(status, message)
      [status, message]
    end

    def parse_json(json)
      JSON.parse(json, symbolize_names: true)
    end

    def find_or_create_ip(ip)
      IpAddress.find_or_create_by(ip: ip)
    end

    def find_or_create_referrer(referrer)
      Referrer.find_or_create_by(referred_by: referrer)
    end

    def find_or_create_resolution(width, height)
      Resolution.find_or_create_by(resolution_width: width, resolution_height: height)
    end

    def find_or_create_url(url, parameters)
      UrlRequest.find_or_create_by(url: url, parameters: parameters)
    end

    def parse_user_agent(user_agent)
      UserAgentParser.parse(user_agent)
    end

    post '/sources' do
      parse_client_params(params)
    end

    post '/sources/:identifier/data' do |identifier|
      client = find_client(identifier)
      return status_message(403, "403 Forbidden - Application not registered") unless client

      payload = parse_json(params[:payload])
      referrer = find_or_create_referrer(payload[:referredBy])
      ip_address = find_or_create_ip(payload[:ip])
      resolution = find_or_create_resolution(payload[:resolutionWidth], payload[:resolutionHeight])
      url_request = find_or_create_url(payload[:url], payload[:parameters].to_s)
      parsed_user_agent = parse_user_agent(payload[:userAgent])
      user_agent = UserAgent.find_or_create_by(browser: parsed_user_agent.family.to_s, os: parsed_user_agent.os.to_s)
      verb = Verb.find_or_create_by(request_type: payload[:requestType])
      payload_request = PayloadRequest.create(requested_at: payload[:requestedAt], responded_in: payload[:respondedIn], event_name: payload[:eventName], ip_address_id: ip_address.id, referrer_id: referrer.id, resolution_id: resolution.id, url_request_id: url_request.id, user_agent_id: user_agent.id, verb_id: verb.id, client_id: client.id)

      if params[:payload] == "{}"
        status_message(400, "400 Bad Request - Missing payload request")
      elsif !payload_request.errors.empty?
        status_message(403, "403 Forbidden - Identifier already exists")
      end
    end
  end
end
