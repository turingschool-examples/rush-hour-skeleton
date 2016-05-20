class Parser
  def self.parse_payload(payload)
    parsed_json = parse_json(payload)
    {"url" => parsed_json["url"],
     "requestedAt" => parsed_json["requestedAt"],
     "respondedIn" => parsed_json["respondedIn"],
     "referredBy" => parsed_json["referredBy"],
     "requestType" => parsed_json["requestType"],
     "parameters" => parsed_json["parameters"],
     "eventName" => parsed_json["eventName"],
     "userAgent" => parse_user_agent(parsed_json["userAgent"]),
     "resolutionWidth" => parsed_json["resolutionWidth"],
     "resolutionHeight" => parsed_json["resolutionHeight"],
     "ip" => parsed_json["ip"]}
  end

  def self.parse_json(json)
    JSON.parse(json)
  end

  def self.parse_user_agent(user_agent)
    UserAgent.parse(user_agent)
  end
end
