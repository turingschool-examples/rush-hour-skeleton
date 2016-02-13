module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    def parse_client_params(params)
      client = Client.new(identifier: params[:identifier],
                          root_url:   params[:rootUrl])

      if client.save
        [200, { identifier: client.identifier }.to_json]
      elsif client.errors.full_messages.first == "Identifier has already been taken"
        [403, "403 Forbidden - Identifier already exists"]
      else
        [400, "400 Bad Request - #{client.errors.full_messages.join(", ")}"]
      end
    end

    def find_client(identifier)
      Client.find_by(identifier: identifier)
    end

    post '/sources' do
      parse_client_params(params)
    end

    post '/sources/:identifier/data' do |identifier|
      client = find_client(identifier)
      return [403, "403 Forbidden - Application not registered"] unless client

      payload = JSON.parse(params[:payload], symbolize_names: true)
      ip_address = IpAddress.find_or_create_by(ip: payload[:ip])
      referrer = Referrer.find_or_create_by(referred_by: payload[:referredBy])
      resolution = Resolution.find_or_create_by(resolution_width: payload[:resolutionWidth], resolution_height: payload[:resolutionHeight])
      url_request = UrlRequest.find_or_create_by(url: payload[:url], parameters: payload[:parameters].to_s)
      parsed_user_agent = UserAgentParser.parse(payload[:userAgent])
      user_agent = UserAgent.find_or_create_by(browser: parsed_user_agent.family.to_s, os: parsed_user_agent.os.to_s)
      verb = Verb.find_or_create_by(request_type: payload[:requestType])
      payload_request = PayloadRequest.create(requested_at: payload[:requestedAt], responded_in: payload[:respondedIn], event_name: payload[:eventName], ip_address_id: ip_address.id, referrer_id: referrer.id, resolution_id: resolution.id, url_request_id: url_request.id, user_agent_id: user_agent.id, verb_id: verb.id, client_id: client.id)

      if params[:payload] == "{}"
        [400, "400 Bad Request - Missing payload request"]
      elsif !payload_request.errors.empty?
        [403, "403 Forbidden - Identifier already exists"]
      end
    end
  end
end
