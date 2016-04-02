require 'json'

class PayloadParser
  attr_reader :status, :body

  def initialize
    @payload_loader = PayloadLoader.new
  end

  def send_request(params)
    parse_and_send_request(params) if params_are_valid?(params, identifier)
    rescue
      return attributes_missing
  end

  def params_are_valid?(params, identifier)
    return payload_missing if params["payload"].nil?
    return not_registered if client_does_not_exist?(identifier)
    true
  end

  def client_does_not_exist?(identifier)
    !Client.exists?(identifier: identifier)
  end

  def parse_and_send_request(params)
    raw_payload = parse_json(params)
    payload = load_payload_request(raw_payload, params["id"])
    save_payload_and_set_status(payload)
  end

  def parse_json(params)
    JSON.parse(params["payload"])
  end

  def load_payload_request(raw_payload, identifier)
    @payload_loader.create_payload_request(params, identifier)
  end

  def save_payload_and_set_status(payload)
    return duplicate_request if payload_request_exists?(payload)
    return payload_successful if payload.save
    attributes_missing
  end

  def payload_request_exists?(payload)
    PayloadRequest.exists?(
      url_id:          payload.url_id,
      requested_at:    payload.requested_at,
      response_time:   payload.response_time,
      referral_id:     payload.referral_id,
      request_type_id: payload.request_type_id,
      event_id:        payload.event_id,
      user_agent_id:   payload.user_agent_id,
      resolution_id:   payload.resolution_id,
      ip_id:           payload.ip_id)
  end

    # Try hash refactoring

  def attributes_missing
    @status = 400
    @body = "missing one or more attributes"
  end

  def duplicate_request
    @status = 403
    @body   = "Payload has already been received.\n"
  end

  def payload_successful
    @status = 200
    @body   = "Payload successfully created.\n"
  end

  def payload_missing
    @status = 400
    @body   = "No payload present.\n"
    false
  end

  def not_registered
    @status = 403
    @body   = "Client does not exist.\n"
    false
  end
end
