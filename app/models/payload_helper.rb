class PayloadHelper

  def self.source_exists?(identifier)
    Source.exists?(identifier: identifier)
  end

  def self.duplicate_source?(payload)
    Payload.exists?(requested_at: payload.requested_at) &&
    Payload.exists?(source_id: payload.source_id)
  end

  def self.add_payload(identifier, payload_hash)
    Payload.new(
          url: payload_hash["url"],
          requested_at: payload_hash["requestedAt"],
          responded_in: payload_hash["respondedIn"],
          referred_by: payload_hash["referredBy"],
          request_type: payload_hash["requestType"],
          parameters: payload_hash["parameters"],
          event_name: payload_hash["eventName"],
          user_agent: payload_hash["userAgent"],
          resolution_width: payload_hash["resolutionWidth"],
          resolution_height: payload_hash["resolutionHeight"],
          id: payload_hash["id"],
          source_id: Source.find_by(identifier: identifier).id 
          )
  end
end