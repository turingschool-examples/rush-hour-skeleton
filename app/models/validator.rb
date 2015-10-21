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

    def self.validate_payload(payload)
    end
  end
end
