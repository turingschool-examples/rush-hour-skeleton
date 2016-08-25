class DataParser

  def self.create(data)
    PayloadRequest.create(
      request_type: RequestType.find_or_create_by( name: data[:requestType] ),
      target_url:   TargetUrl.find_or_create_by( name: data[:url] ),
      referrer_url: ReferrerUrl.find_or_create_by( name: data[:referredBy] ),
      resolution:   Resolution.find_or_create_by(parse_resolutions(data)),
      u_agent:      UAgent.find_or_create_by(parse_user_agent(data)),
      ip:           Ip.find_or_create_by({address: data[:ip]}),
      responded_in: data[:respondedIn],
      requested_at: data[:requestedAt]
    )
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
