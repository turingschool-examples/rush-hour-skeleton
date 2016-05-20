class DataLoader
  def self.load(payload, identifier)
    if !Client.find_by(identifier: identifier)
      controller_hash = {status: 403, body: "Application is not registered"}
    elsif payload.nil?
      controller_hash = {status: 400, body: "Missing payload"}
    elsif check_existance(payload, identifier) == false
      payload = PayloadRequest.new({
        url:          Url.find_or_create_by(name: payload["url"]),
        referrer:     Referrer.find_or_create_by(name: payload["referredBy"]),
        request_type: RequestType.find_or_create_by(verb: payload["requestType"]),
        requested_at: RequestedAt.find_or_create_by(time: payload["requestedAt"]),
        event_name:   EventName.find_or_create_by(name: payload["eventName"]),
        user_agent:   PayloadUserAgent.find_or_create_by(browser: payload["userAgent"].browser, platform: payload["userAgent"].platform),
        responded_in: RespondedIn.find_or_create_by(time: payload["respondedIn"]),
        parameter:    Parameter.find_or_create_by(list: payload["parameters"].to_s),
        ip:           Ip.find_or_create_by(value: payload["ip"]),
        resolution:   Resolution.find_or_create_by(width: payload["resolutionWidth"], height: payload["resolutionHeight"]),
        client:       Client.find_by(identifier: identifier) })
      payload.save
      controller_hash = {status: 200, body: "OK"}
    else
      controller_hash = {status: 403, body: "Payload already exists"}
    end
      controller_hash
  end

  def self.check_existance(payload, identifier)

    PayloadRequest.exists?({
      url:          Url.find_by(name: payload["url"]),
      referrer:     Referrer.find_by(name: payload["referredBy"]),
      request_type: RequestType.find_by(verb: payload["requestType"]),
      requested_at: RequestedAt.find_by(time: payload["requestedAt"]),
      event_name:   EventName.find_by(name: payload["eventName"]),
      user_agent:   PayloadUserAgent.find_by(browser: payload["userAgent"].browser, platform: payload["userAgent"].platform),
      responded_in: RespondedIn.find_by(time: payload["respondedIn"]),
      parameter:    Parameter.find_by(list: payload["parameters"].to_s),
      ip:           Ip.find_by(value: payload["ip"]),
      resolution:   Resolution.find_by(width: payload["resolutionWidth"], height: payload["resolutionHeight"]),
      client:       Client.find_by(identifier: identifier)
      })
  end

end
