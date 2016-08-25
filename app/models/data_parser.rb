class DataParser

  def self.create(params)
    if params[:payload].nil?
      parse_client_data(params)
    else
      parse_payload_data(params)
    end
  end

  def self.parse_client_data(params)
    Client.create({ identifier: params[:identifier],
                    root_url:   params[:rootUrl] })
  end

  def self.parse_payload_data(params)
    data = params[:payload]
    data[:client_identifier] = find_client_identifier(data[:referredBy])
    data[:resolution_info] = parse_resolutions(data)
    data[:u_agent_info] = parse_user_agent(data)
    CreatePayloadRequest.create(data)
  end

  def self.find_client_identifier(referred_by)
    "http://#{URI.parse(referred_by).host}"
  end

  def self.parse_resolutions(data)
    { width:  data[:resolutionWidth],
      height: data[:resolutionHeight] }
  end

  def self.parse_user_agent(data)
    user_agent = UserAgent.parse(data[:userAgent])
    { browser: user_agent.browser,
      os:      user_agent.platform }
  end
end
