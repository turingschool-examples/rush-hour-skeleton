require 'user_agent_parser'

class PayloadAnalyzer

  incoming_keys = [:requestType, :userAgent, :resolutionWidth, :resolutionHeight]
  user_agent = UserAgentParser.parse(raw_payload.delete(:userAgent))
  os = user_agent.os
  browser = user_agent.to_s
  resolution = resolution_parse(raw_payload.delete(:resolutionWidth), raw_payload.delete(:resolutionHeight))
  verb = raw_payload.delete(:requestType)
  referred = raw_payload.delete(:referredBy)
  url = raw_payload.delete(:url)
  ip = raw_payload.delete(:ip)
  eventname = raw_payload.delete(:eventName)

  models = [RequestType, ScreenResolution, Referred, Ip, Url, EventName, UserAgent]
  values = [{verb: verb}, {size: resolution}, {name: referred}, {address: ip}, {route: url}, {name: eventname}, {os: os, browser: browser}]
  payload = Payload.Create(raw_payload)

  models.each_with_index do |model, index|
    model.find_or_create_by(model.find_or_create_by(values[index]))
  end


  # RequestType.find_or_create_by(verb: verb) << payload
  # ScreenResolution.find_or_create_by(size: resolution) << payload
  # Referred.find_or_create_by(name: referred) << payload
  # Ip.find_or_create_by(address: ip) << payload
  # Url.find_or_create_by(route: url) << payload
  # EventName.find_or_create_by(name: eventname) << payload
  # UserAgent.find_or_create_by(os: os, browser: browser) << payload


  def resolution_parse(width, height)
    width + "x" + height
  end

end
