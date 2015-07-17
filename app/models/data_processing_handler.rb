module TrafficSpy
  class DataProcessingHandler
    attr_reader :payload, :identifier, :body, :status

    def initialize(raw_payload, identifier)
      @payload    = raw_payload
      # @payload = PayloadParser.new(raw_payload)
      @identifier = identifier
      # @registration = Registration.find_by(identifier: identifier)
      call
      self
    end

    def call
      exist = Registration.exists?(identifier: identifier)

      if !exist
        @status = 403
        @body   = "Application Not Registered - 403 Forbidden"
      elsif payload[:payload].nil?
        @status = 400
        @body   = "Missing Payload - 400 Bad Request"
      else
        check_for_repeat_payload
      end
    end

    def check_for_repeat_payload
      parser      = PayloadParser.new(payload)
      current_sha = Digest::SHA1.hexdigest(parser.payload.to_s)
      if Payload.exists?(payload_sha: current_sha)
        @status = 403
        @body   = "Already Received Request - 403 Forbidden"
      else
        save_payload(current_sha)
      end
    end

    def save_payload(current_sha)
      registration = Registration.find_by(:identifier => identifier)
      parser       = PayloadParser.new(payload)
      registration.payloads.create(url: Url.find_or_create_by(parser.url))
      registration.payloads.create(screen_resolution: ScreenResolution.find_or_create_by(parser.screen_resolution))
      registration.payloads.create(browser: Browser.find_or_create_by(parser.browser))
      registration.payloads.create(event: Event.find_or_create_by(parser.event))
      registration.payloads.create(operating_system: OperatingSystem.find_or_create_by(parser.operating_system))
      payload = registration.payloads.last
      payload.update(payload_sha: current_sha)
      @status = 200
      @body   = "Success"
    end
  end
end
