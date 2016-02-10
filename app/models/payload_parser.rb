require 'user_agent_parser'
class PayloadParser
  def self.parse(data)
    ua = UserAgentParser.parse(data[:userAgent])
    ({
      url: Url.find_or_create_by(address: data[:url]),
      requested_at: data[:requestedAt],
      responded_in: data[:respondedIn],
      referrer: Referrer.find_or_create_by(address: data[:referredBy]),
      request: Request.find_or_create_by(verb: data[:requestType]),
      event: Event.find_or_create_by(name: data[:eventName]),
      user_agent: UserAgent.find_or_create_by(browser: ua.family, platform: ua.os.to_s),
      resolution: Resolution.find_or_create_by(width: data[:resolutionWidth], height: data[:resolutionHeight]),
      ip: Ip.find_or_create_by(address: data[:ip])
    })
  end



end
