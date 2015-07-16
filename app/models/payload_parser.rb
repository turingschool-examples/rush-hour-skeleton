module TrafficSpy
  class PayloadParser

    attr_reader :result

    def initialize(data, identifier)
      @digest     = Digest::SHA1.hexdigest(data.to_s)
      @data       = data
      @identifier = identifier
    end

    def validate
      if missing_payload?
        @result = { status: 400, body: "missing payload" }
      elsif already_received_request?
        @result = { status: 403, body: "already received request" }
      elsif !application_registered?
        @result = { status: 403, body: "application not registered" }
      else
        save_payload_data
        @result = { status: 200, body: "OK" }
      end
    end

    private

    def missing_payload?
      @data.nil?
    end

    def already_received_request?
      Payload.exists?(digest: @digest)
    end

    def application_registered?
      Source.exists?(identifier: @identifier)
    end

    def save_payload_data
      source = Source.find_by(identifier: @identifier)
      source.payloads.create(normalized_payload_data)
    end

    def normalized_payload_data
      parsed_data = JSON.parse(@data)
      { digest: @digest,
        url_id: Url.find_or_create_by(address: parsed_data["url"]).id,
      }
    end
  end
end
