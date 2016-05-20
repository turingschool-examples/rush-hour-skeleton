class DataLoader
  def self.load(payload, identifier)
    payload = PayloadRequest.new({
      url:          Url.find_or_create_by(name: payload["url"]),
      referrer:     Referrer.find_or_create_by(name: payload["referredBy"]),
      request_type: RequestType.find_or_create_by(verb: payload["requestType"]),
      requested_at: payload["requestedAt"],
      event_name:   EventName.find_or_create_by(name: payload["eventName"]),
      user_agent:   PayloadUserAgent.find_or_create_by(browser: payload["userAgent"].browser, platform: payload["userAgent"].platform),
      responded_in: payload["respondedIn"],
      parameters:   payload["parameters"],
      ip:           Ip.find_or_create_by(value: payload["ip"]),
      resolution:   Resolution.find_or_create_by(width: payload["resolutionWidth"], height: payload["resolutionHeight"]),
      client:       Client.find_by(identifier: identifier) })
  end


end
