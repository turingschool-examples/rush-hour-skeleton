module TrafficSpy
  class PayloadValidator
    attr_reader :identifier, :params, :message, :status

    def initialize(params, identifier)
      @params = params
      @identifier = identifier
    end

    def validate
      case
        when params_dont_exist?
          @status = 400
          @message = "invalid payload - either no payload or payload is missing data"
        when source_doesnt_exist?
          @status = 400
          @message = "you never registered your url ya ding dong"
        else
         create_new_payload(params)
      end
    end

    def create_new_payload(params)
      parsed_payload = PayloadParser.new.parse(params)
      parsed_payload_sha = ShaGenerator.create_sha(parsed_payload)
      parsed_payload[:sha] = parsed_payload_sha
      payload_entry = Payload.create(parsed_payload)
      source_id = Source.find_by(:identifier == identifier).id
      payload_entry.update_attribute(:source_id, source_id)
      return_status_and_message(payload_entry)
    end

    def return_status_and_message(payload_entry)
      if payload_entry.errors.full_messages.include?("Sha has already been taken")
        @status = 403
        @message = "payload already exists"
      else
        @status = 200
      end
    end

    def params_dont_exist?
      if params == nil || params == "null"
        true
      else
        false
      end
    end

    def source_doesnt_exist?
      if Source.find_by(identifier: identifier).nil?
        true
      else
        false
      end
    end

  end
end
