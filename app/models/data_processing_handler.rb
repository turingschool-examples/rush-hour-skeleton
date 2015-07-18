class DataProcessingHandler
  attr_reader :payload,
              :body,
              :status,
              :parser

  def initialize(raw_payload, identifier)
    @parser       = PayloadParser.new(raw_payload)
    @payload      = @parser.payload
    @registration = Registration.find_by(identifier: identifier)
    @status       = 0
    @body         = ''
    process(@registration, @payload)
  end

  def process(registration, payload)

    if registration.nil?
      @status = 403
      @body   = 'Application Not Registered - 403 Forbidden'
    elsif payload.nil?
      @status = 400
      @body   = 'Missing Payload - 400 Bad Request'
    else

      current_sha = Digest::SHA1.hexdigest(payload.to_s)

      if Payload.exists?(payload_sha: current_sha)
        @status = 403
        @body   = 'Already Received Request - 403 Forbidden'
      else
        poplate_data(registration)
        store_payload_sha(current_sha, registration)
        @status = 200
        @body   = 'Success'
      end

    end
  end

  private

  def store_payload_sha(current_sha, registration)
    payload = registration.payloads.last
    payload.update(payload_sha: current_sha)
  end

  def poplate_data(registration)
    registration.payloads.create(url: Url.find_or_create_by(parser.url))
    registration.payloads.create(screen_resolution: ScreenResolution.find_or_create_by(parser.screen_resolution))
    registration.payloads.create(browser: Browser.find_or_create_by(parser.browser))
    registration.payloads.create(event: Event.find_or_create_by(parser.event))
    registration.payloads.create(operating_system: OperatingSystem.find_or_create_by(parser.operating_system))
  end

end
