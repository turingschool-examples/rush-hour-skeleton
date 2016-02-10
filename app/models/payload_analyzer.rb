require 'user_agent_parser'

class PayloadAnalyzer

  def parse(raw_payload)
    user_agent = UserAgentParser.parse(raw_payload.delete(:userAgent))
    os = user_agent.os.to_s
    browser = user_agent.to_s
    resolution = resolution_parse(raw_payload.delete(:resolutionWidth), raw_payload.delete(:resolutionHeight))
    verb = raw_payload.delete(:requestType)
    referred = raw_payload.delete(:referredBy)
    url = raw_payload.delete(:url)
    ip = raw_payload.delete(:ip)
    eventname = raw_payload.delete(:eventName)
    requested_at = raw_payload[:requestAt]
    responded_in = raw_payload[:respondedIn]
    parameters = raw_payload[:parameters]

    payload = Payload.create(requested_at: requested_at, responded_in: responded_in, parameters: parameters)

    RequestType.find_or_create_by(verb: verb).payloads << payload
    ScreenResolution.find_or_create_by(size: resolution).payloads << payload
    Referred.find_or_create_by(name: referred).payloads << payload
    Ip.find_or_create_by(address: ip).payloads << payload
    Url.find_or_create_by(route: url).payloads << payload
    EventName.find_or_create_by(name: eventname).payloads << payload
    UserAgent.find_or_create_by(os: os, browser: browser).payloads << payload
  end

  def resolution_parse(width, height)
    width + "x" + height
  end
  
end
