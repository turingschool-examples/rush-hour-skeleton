module TrafficSpy
  class PayloadValidator
    attr_reader :identifier, :params, :message
    attr_accessor  :status

    def initialize(params, identifier)
      @params = params
      @identifier = identifier
    end

    def validate
      if params.has_key?("payload")
        if Source.find_by(identifier: identifier).nil?
          @status = 400
          @message = "you never registered your url ya ding dong"
        elsif params["payload"] == "null" || params["payload"] == nil || params["payload"] == ""
          @status = 400
          @message = "your payload is missing data ya ding dong"
        else
          payload = PayloadParser.new.change_names(params)
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
        @message = "missing payload ya ding dong"
      end
    end
  end
end
