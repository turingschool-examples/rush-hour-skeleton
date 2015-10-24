require 'json'
require 'digest'

module TrafficSpy
  class Validator
    def initialize(source)
      @source = source
    end

    def self.validate_source(source)
      if source.save
        [200, {identifier: source.identifier}.to_json]
      elsif Source.all.exists?(identifier: source.identifier)
        [403, source.errors.full_messages.join(", ")]
      else
        [400, source.errors.full_messages.join(", ")]
      end
    end

    def self.prepare_payload(raw_payload)
      payload = JSON.parse(raw_payload)
      payload["requested_at"] = payload.delete("requestedAt")
      payload["responded_in"] = payload.delete("respondedIn")
      payload["referred_by"] = payload.delete("referredBy")
      payload["request_type"] = payload.delete("requestType")
      payload["event_name"] = payload.delete("eventName")
      payload["user_agent"] = payload.delete("userAgent")
      payload["resolution_width"] = payload.delete("resolutionWidth")
      payload["resolution_height"] = payload.delete("resolutionHeight")
      unique_hash = Digest::SHA2.hexdigest(raw_payload)
      payload["unique_hash"] = unique_hash
      payload
    end

    def self.validate_payload(identifier, payload, source)
      if Source.find_by(identifier: identifier)
        if payload.save
          [200, "OK"]
        elsif Payload.all.exists?(unique_hash: payload.unique_hash)
          [403, "Already Received Request"]
        else
          [400, "Payload Missing"]
        end
      else
        [403, "App Not Registered!"]
      end
    end

    def self.add_source_id(payload, source)
      payload.update_attribute("source_id", source.id)
    end
  end
end
