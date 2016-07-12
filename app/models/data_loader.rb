class DataLoader

  def self.load(payload, identifier)
    if !Client.find_by(identifier: identifier)
     {status: 403, body: "Application is not registered"}
     require "pry"; binding.pry
    elsif payload.nil?
     {status: 400, body: "Missing payload"}
   elsif check_existence(payload, identifier) == false

      result = PayloadRequest.new ({
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

        result.save
        {status: 200, body: "OK"}
      else
        {status: 403, body: "Payload already exists"}
      end
    end

    def self.check_existence(payload, identifier)

      PayloadRequest.exists?({
        url:            Url.find_by(address: payload["url"]),
        referrer:       Referrer.find_by(address: payload["referredBy"]),
        request_type:   RequestType.find_by(verb: payload["requestType"]),
        requested_at:   payload["requestedAt"],
        software_agent: SoftwareAgent.find_by(os: payload["software_agent"].os, browser: payload["software_agent"].browser),
        responded_in:   payload["respondedIn"],
        parameter:      Parameter.find_by(user_input: payload["parameters"].to_s),
        ip:             Ip.find_by(address: payload["ip"]),
        resolution:     Resolution.find_by(width: payload["resolutionWidth"], height: payload["resolutionHeight"]),
        client:         Client.find_by(identifier: identifier)
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
