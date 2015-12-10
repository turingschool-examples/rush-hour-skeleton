class PayloadHandler
  attr_reader :status, :body, :payload, :hashed_payload, :parameters

  def initialize(parameters)
    @parameters = parameters
    parse_and_save_payload unless parameters["payload"].nil?
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

    url = Url.create(path: payload["url"],
               referred_by: payload["referredBy"],
               request_type: payload["requestType"],
               parameters: payload["parameters"])
    event = Event.create(responded_in: payload["respondedIn"],
                 requested_at: payload["requestedAt"],
                 event_name: payload["eventName"])
    user_agent = UserAgent.create(web_browser: payload["userAgent"],
                          operating_system: payload["userAgent"],
                          resolution_width: payload["resolutionWidth"],
                          resolution_height: payload["resolutionHeight"],
                          ip_address: payload["ip"])
    client.urls << url
    client.events << event
    url.events << event
    client.user_agents << user_agent
    url.user_agents << user_agent
  end

  def parse_and_save_payload
    @hashed_payload = Digest::SHA1.hexdigest parameters["payload"]
    @payload = JSON.parse(parameters["payload"])
  end

  def duplicate_payload?
    if HexedPayload.exists?(hexed_payload: hashed_payload)
      true
    else
      HexedPayload.create(hexed_payload: hashed_payload)
      false
    end
  end

  def unregistered_user?
    Client.find_by(name: parameters["identifier"]) ? false : true
  end

  def response_status_and_body
    @status = generate_status
    @body = gener

    if payload.nil?
      @status = 400
      @body = "Payload Missing."
    elsif unregistered_user?
      @status = 403
      @body = "Application Not Registered."
    elsif duplicate_payload?
      @status = 403
      @body = "Duplicate Payload."
    else
      @status = 200
    end
  end

end
