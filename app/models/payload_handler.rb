class PayloadHandler
  attr_reader :status, :body, :payload, :hashed_payload, :parameters

  def initialize(parameters)
    @parameters = parameters
    parse_and_save_payload unless parameters["payload"].nil?
    response_status_and_body
  end

  def parse_and_save_payload
    @hashed_payload = Digest::SHA1.hexdigest parameters["payload"]
    @payload = JSON.parse(parameters["payload"]) unless parameters["payload"].nil?
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
