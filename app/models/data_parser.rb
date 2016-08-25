class DataParser

  def self.create(data)
    PayloadRequest.create(
      request_type: RequestType.create({name: data[:requestType]}),
      target_url:   TargetUrl.create({name: data[:url]}),
      referrer_url: ReferrerUrl.create({name: data[:referredBy]}),
      resolution:   Resolution.create(parse_resolutions(data)),
      u_agent:      UAgent.create(parse_user_agent(data)),
      ip:           Ip.create({address: data[:ip]}),
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
