module TrafficSpy
  class PayloadValidator
    attr_reader :identifier, :params, :message, :status

    def initialize(params, identifier)
      @params = params
      @identifier = identifier
    end

    def validate
      if params
        if Source.find_by(identifier: identifier).nil?
          @status = 400
          @message = "you never registered your url ya ding dong"
        elsif params == "null" || params == nil
          @status = 400
          @message = "your payload is missing data ya ding dong"
        else
          payload = PayloadParser.new.parse(params)
          payload_sha = ShaGenerator.create_sha(payload)
          payload[:sha] = payload_sha
          pi = Payload.create(payload)

          if pi.errors.full_messages.include?("Sha has already been taken")
            @status = 403
            @message = "payload already exists"
          else
            @status = 200
          end

        end
      else
        @status = 400
        @message = "invalid payload - either no payload or payload is missing data"
      end
    end

  def validate
    if params_exist? == false
        @status = 400
        @message = "invalid payload - either no payload or payload is missing data"
      else
        if Source.find_by(identifier: identifier).nil?
          @status = 400
          @message = "you never registered your url ya ding dong"
        else
          payload = PayloadParser.new.parse(params)
          payload_sha = ShaGenerator.create_sha(payload)
          payload[:sha] = payload_sha
          payload_entry = Payload.create(payload)
          if payload_entry.errors.full_messages.include?("Sha has already been taken")
            @status = 403
            @message = "payload already exists"
          else
            @status = 200
          end
      end
    end
  end

    def validate
      case
        when params_exist? == false
          @status = 400
          @message = "invalid payload - either no payload or payload is missing data"
        when source_exists? == false
          @status = 400
          @message = "you never registered your url ya ding dong"
        else
         create_new_payload(params)
      end
    end


    def create_new_payload(params)
      payload = PayloadParser.new.parse(params)
      payload_sha = ShaGenerator.create_sha(payload)
      payload[:sha] = payload_sha
      payload_entry = Payload.create(payload)
      if payload_entry.errors.full_messages.include?("Sha has already been taken")
        @status = 403
        @message = "payload already exists"
      else
        @status = 200
      end
    end

    def params_exist?
      if params == nil || params == "null"
        false
      else
        true
      end
    end

    def source_exists?
      if Source.find_by(identifier: identifier).nil?
        false
      else
        true
      end
    end

  end
end
