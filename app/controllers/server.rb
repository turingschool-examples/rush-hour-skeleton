module RushHour
  class Server < Sinatra::Base

    not_found do
      erb :error
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

    def find_or_create_user_agent(user_agent)
      parsed_user_agent = UserAgentParser.parse(user_agent)
      UserAgent.find_or_create_by(browser: parsed_user_agent.family.to_s,
                                  os: parsed_user_agent.os.to_s)
    end

    def find_or_create_verb(request_type)
      Verb.find_or_create_by(request_type: request_type)
    end

    def format_payload(payload)
      {
        referrer:    find_or_create_referrer(payload[:referredBy]).id,
        ip_address:  find_or_create_ip(payload[:ip]).id,
        resolution:  find_or_create_resolution(payload[:resolutionWidth], payload[:resolutionHeight]).id,
        url_request: find_or_create_url(payload[:url], payload[:parameters].to_s).id,
        user_agent:  find_or_create_user_agent(payload[:userAgent]).id,
        verb:        find_or_create_verb(payload[:requestType]).id
      }
    end

    def create_payload_request(client)
      payload = ApplicationHelper.parse_json(params[:payload])
      foreign_keys = format_payload(payload)
      PayloadRequest.create(requested_at: payload[:requestedAt], responded_in: payload[:respondedIn], event_name: payload[:eventName],  referrer_id: foreign_keys[:referrer], ip_address_id: foreign_keys[:ip_address], resolution_id: foreign_keys[:resolution], url_request_id: foreign_keys[:url_request], verb_id: foreign_keys[:verb], client_id: client.id )
    end

    def payload_status_message(params, payload_request)
      if params[:payload] == "{}"
        ApplicationHelper.status_message(400, "400 Bad Request - Missing payload request")
      elsif !payload_request.errors.empty?
        ApplicationHelper.status_message(403, "403 Forbidden - Identifier already exists")
      end
    end

    post '/sources' do
      ClientHelper.parse_client_params(params)
    end

    post '/sources/:identifier/data' do |identifier|
      client = ClientHelper.find_client(identifier)
      return ApplicationHelper.status_message(403, "403 Forbidden - Application not registered") unless client

      payload_request = create_payload_request(client)

      payload_status_message(params, payload_request)
    end
  end
end
