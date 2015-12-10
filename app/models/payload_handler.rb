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
    #
    # client.payloads.create(path: ,
    #                       event: parameters["eventName"])
                            # event: find_by .......
    #
    #
    # )
    new_payload = Payload.create(path: payload["url"],
                             referred_by: payload["referredBy"],
                             request_type: payload["requestType"],
                             parameters: payload["parameters"],
                             responded_in: payload["respondedIn"],
                             requested_at: payload["requestedAt"],
                             event_name: payload["eventName"],
                             web_browser: payload["userAgent"],
                             operating_system: payload["userAgent"],
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
    # @status = generate_status
    # @body = gener
    if payload.nil?
      @status = 400
      @body = "Payload Missing."
    elsif unregistered_user?
      @status = 403
      @body = "Application Not Registered."
    elsif duplicate_payload?(hashed_payload)
      @status = 403
      @body = "Duplicate Payload."
    else
      @status = 200
    end

  end

  def payload_invalid?
    parameters["payload"].nil? || parameters['payload'].empty?
  end

end
