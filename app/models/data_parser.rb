require 'useragent'

class DataParser

  def self.create(data)
    request_type = RequestType.create({ name: data[:requestType]})
    target_url = TargetURL.create({ name: data[:url]})
    referrer_url = ReferrerURL.create({ name: data[:referredBy] })
    resolution = Resolution.create(parse_resolutions(data))
    user_agent = RushHour::UserAgent.create(parse_user_agent(data))
    ip = IP.create({address: data[:ip]})

    PayloadRequest.create(
      request_type_id: request_type.id,
      target_url_id: target_url.id,
      referrer_url_id: referrer_url.id,
      resolution_id: resolution.id,
      user_agent_id: user_agent.id,
      ip_id: ip.id,
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
      os: user_agent.platform }
  end
end
