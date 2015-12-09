class PayloadHandler
  attr_reader :payload, :hashed_payload, :parameters

  def initialize(parameters)
    @parameters = parameters
    parse_and_save_payload unless parameters["payload"].nil?
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
    Client.find_by(name: parameters["identifier"])
  end

  def status
    if payload.nil?
      400
    elsif duplicate_payload? || unregistered_user?
      403
    else
      200
    end
  end

  def body
    if payload.nil?
      "Payload Missing."
    elsif duplicate_payload?
      "Duplicate Payload."
    elsif unregistered_user?
      "Application Not Registered."
    end
  end

end
