require 'json'

class PayloadParser
  attr_reader :status, :body

  def initialize
    @payload_loader = PayloadLoader.new
  end

  def parse(params)
    identifier = params["id"]
    if valid_params?(params, identifier)
      raw_payload = parse_json(params)
      create_status_and_body(raw_payload, identifier)
    end
    rescue
      return attributes_missing
  end

  def valid_params?(params, identifier)
    if params["payload"].nil?
      missing_payload
      false
    elsif !Client.exists?(identifier: identifier)
      application_not_registered
      false
    else
      true
    end
  end


  def parse_json(params)
    JSON.parse(params["payload"])
  end

  def create_status_and_body(params, identifier)
      payload = @payload_loader.create_payload_request(params, identifier)
      if PayloadRequest.exists?(
        url_id:          payload.url_id,
        requested_at:    payload.requested_at,
        response_time:   payload.response_time,
        referral_id:     payload.referral_id,
        request_type_id: payload.request_type_id,
        event_id:        payload.event_id,
        user_agent_id:   payload.user_agent_id,
        resolution_id:   payload.resolution_id,
        ip_id:           payload.ip_id)
        already_received_request
      elsif payload.save
        payload_successful
      else
        attributes_missing
      end
    end

    # Try hash refactoring

  def attributes_missing
    @status = 400
    @body = "missing one or more attributes"
  end

  def already_received_request
    @status = 403
    @body   = "Payload has already been received.\n"
  end

  def payload_successful
    @status = 200
    @body   = "Payload successfully created.\n"
  end

  def missing_payload
    @status = 400
    @body   = "No payload present.\n"
  end

  def application_not_registered
    @status = 403
    @body   = "Client does not exist.\n"
  end

end
