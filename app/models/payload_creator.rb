require_relative "source"
require 'json'

class PayloadCreator
  attr_reader :status, :body
  
  def initialize(payload, identifier)
    @payload = payload
    @identifier = identifier
    
    @status, @body = result
  end

  def registered?
    Source.exists?(identifier: @identifier)
  end

  def missing_payload?
    @payload.nil?
  end

  def payload_data
    JSON.parse(@payload)
  end

  def generate_payload
    source = Source.find_by(identifier: @identifier)
    source.payloads.new({requested_at: payload_data["requestedAt"],
                         user_agent:   payload_data["userAgent"],
                         url:          payload_data["url"],
                         responded_in: payload_data["respondedIn"],
                         resolution_width: payload_data["resolutionWidth"],
                         resolution_height: payload_data["resolutionHeight"]})
  end
  
  def result
    return [403, "Unregistered source"] unless registered?
    return [400, "Missing payload data"] if missing_payload?

    payload = generate_payload
    
    if payload.save
      [200, "OK"]
    else
      [403, "Already received payload"]
    end
  end
end
