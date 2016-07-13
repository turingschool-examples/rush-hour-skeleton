class DataLoader

  def self.load(payload, identifier)
     payload_new = process_payload(payload, identifier)
     if !Client.find_by(identifier: identifier)
       {status: 403, body: "Application is not registered"}
     elsif payload.nil?
       {status: 400, body: "Missing payload"}
     elsif check_existence(payload_new, identifier) == true
       {status: 403, body: "Payload already exists"}
     else
       payload_new.save
       {status: 200, body: "OK"}
     end
  end

  def self.process_payload(payload, identifier)
    PayloadRequest.new({
      url:              Url.find_or_create_by(address: payload["url"]),
      requested_at:     payload["requestedAt"],
      responded_in:     payload["respondedIn"],
      request_type:     RequestType.find_or_create_by(verb: payload["requestType"]),
      resolution:       Resolution.find_or_create_by(height: payload["resolutionWidth"], width: payload["resolutionHeight"]),
      referrer:         Referrer.find_or_create_by(address: payload["referredBy"]),
      software_agent:   SoftwareAgent.find_or_create_by(os: payload["software_agent"].os, browser: payload["software_agent"].browser),
      ip:               Ip.find_or_create_by(address: payload["ip"]),
      client:           Client.find_by(identifier: identifier),
      parameter:        Parameter.find_or_create_by(user_input: payload["parameters"].to_s) })
  end

  def self.check_existence(payload, identifier)
    PayloadRequest.exists?({
      url_id:            Url.find_by(address: payload[:url_id]),
      referred_by_id:       Referrer.find_by(address: payload[:referred_by_id]),
      request_type_id:   RequestType.find_by(verb: payload[:request_type_id]),
      requested_at:   payload[:requested_at],
      software_agent_id: SoftwareAgent.find_by(os: payload[:software_agent_id], browser: payload[:software_agent_id]),
      responded_in:   payload[:responded_in],
      parameter_id:      Parameter.find_by(user_input: payload[:parameter_id]),
      ip_id:             Ip.find_by(address: payload[:ip_id]),
      client_id:         Client.find_by(identifier: identifier)
      })
  end

  def self.error_check(client)
    if client.error_message.include?("can't be blank")
      {status: 400, body: client.error_message}
    elsif client.error_message.include?("has already been taken")
      {status: 403, body: client.error_message}
    else
      {status: 200, body: client.identifier}
    end
  end
end
