class DataLoader

  def self.load(payload, identifier)
    if !Client.find_by(identifier: identifier)
      response = {status: 403, body: "Application is not registered"}
    elsif payload.nil?

      response = {status: 400, body: "Missing payload"}
    elsif check_existance(payload, identifier) == false

      result = PayloadRequest.new ({
        url:              Url.find_or_create_by(address: payload["url"]),
        requested_at:     payload["requestedAt"],
        responded_in:     payload["respondedIn"],
        request_type:     RequestType.find_or_create_by(verb: payload["requestType"]),
        resolution:       Resolution.find_or_create_by(height: payload["resolutionWidth"], width: payload["resolutionHeight"]),
        referrer:         Referrer.create(address: payload["referredBy"]),
        software_agent:   SoftwareAgent.create(os: payload["software_agent"].os, browser: payload["software_agent"].browser),
        ip:               Ip.create(address: payload["ip"]),
        client:           Client.find_by(identifier: identifier),
        parameter:        Parameter.find_or_create_by(user_input: payload["parameters"].to_s) })

        result.save
        response = {status: 200, body: "OK"}
      else
        response = {status: 403, body: "Payload already exists"}
      end
      response
    end

    def self.check_existance(payload, identifier)

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
    end
