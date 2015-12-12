class PayloadHandler
  attr_reader :status, :body, :payload, :hashed_payload, :parameters

  def initialize(parameters)
    @parameters = parameters
    parse_and_save_payload unless payload_invalid?
    response_status_and_body
    distribute_payload if status == 200
  end

  def distribute_payload
    client = Client.find_by(name: parameters["identifier"])
    agent_orange = AgentOrange::UserAgent.new(payload["userAgent"])
    new_payload = Payload.create(path: payload["url"],
                             referred_by: payload["referredBy"],
                             request_type: payload["requestType"],
                             parameters: payload["parameters"],
                             responded_in: payload["respondedIn"],
                             requested_at: payload["requestedAt"],
                             event_name: payload["eventName"],
                             web_browser: agent_orange.device.engine.browser,
                             operating_system: agent_orange.device.operating_system,
                             resolution_width: payload["resolutionWidth"],
                             resolution_height: payload["resolutionHeight"],
                             ip_address: payload["ip"],
                             hexed_payload: hashed_payload)
    client.payloads << new_payload
  end

  def parse_and_save_payload
    @hashed_payload = Digest::SHA1.hexdigest parameters["payload"]
    @payload = JSON.parse(parameters["payload"])
  end

  def duplicate_payload?(hex_code)
    Payload.find_by(hexed_payload: hex_code) ? true : false
  end

  def unregistered_user?
    Client.find_by(name: parameters["identifier"]) ? false : true
  end

  def response_status_and_body
    @status = generate_status
    @body = generate_body
  end

  def generate_body
    return "Payload Missing." if payload_invalid?
    return "Application Not Registered." if unregistered_user?
    return "Duplicate Payload." if duplicate_payload?(hashed_payload)
  end

  def generate_status
    return 400 if payload_invalid?
    return 403 if unregistered_user? || duplicate_payload?(hashed_payload)
    return 200
  end

  def payload_invalid?
    parameters["payload"].nil? || parameters['payload'].empty?
  end

end
