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

    def self.validate_payload(identifier, payload)
      if Source.find_by(identifier: identifier)
        if payload.save
          [200, "OK"]
        elsif Payload.all.exists?(unique_hash: payload.unique_hash)
          [403, "Already Received Request"]
        else
          "SomeSHIT"
        end
      else
        [403, "App Not Registered!"]
      end
    end
  end
end
