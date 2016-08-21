class Parser
  attr_reader :payload

  def json(string)
    JSON.parse(string, {:symbolize_names => true})
  end

  def parse_client_params(params)
    {identifier: params[:identifier], root_url: params[:rootURL]}
  end

  def create_resolution(payload)
    width = payload[:resolutionWidth]
    height = payload[:resolutionHeight]
    Resolution.where(:width=> width).where(:height=> height).first_or_create
  end

  def create_user_agent(user_agent)
    parsed_agent = UserAgent.parse(user_agent)
    browser = parsed_agent.browser
    platform = parsed_agent.platform
    UserAgentB.where(:browser=> browser).where(:platform=> platform).first_or_create
  end

  def create_url(url)
    Url.where(:address=> url).first_or_create
  end

  def create_referrer(referrer)
    Referrer.where(:address=> referrer).first_or_create
  end

  def create_request(request)
    Request.where(:verb=> request).first_or_create
  end

  def create_event(event)
    Event.where(:name=> event).first_or_create
  end

  def create_ip(ip)
    Ip.where(:address=> ip).first_or_create
  end

  def find_client(identifier)
    Client.find_by(identifier: identifier)
  end

  def sha_generator(string)
    Digest::SHA1.hexdigest(string)
  end

  def parse_payload(string, identifier)
    payload = json(string)
    @payload = PayloadRequest.create(
                           :requested_at=>  payload[:requestedAt],
                           :responded_in=>  payload[:respondedIn],
                           :parameters=>    payload[:parameters],
                           :url=>           create_url(payload[:url]),
                           :referrer=>      create_referrer(payload[:referredBy]),
                           :request=>       create_request(payload[:requestType]),
                           :event=>         create_event(payload[:eventName]),
                           :user_agent_b=>  create_user_agent(payload[:userAgent]),
                           :resolution=>    create_resolution(payload),
                           :ip=>            create_ip(payload[:ip]),
                           :client_id =>    find_client(identifier).id,
                           :key =>          sha_generator(string)
                          )


  # payload_request = PayloadRequest.new(requested_at: requested)
  #
  # payload_request.url.where(address: "hello.com").first_or_create
  # payload_request.request_type.create(address: "hello.com")
  # payload_request.event_name.create(address: "hello.com")
  # payload_request.url.create(address: "hello.com")
  # payload_request.url.create(address: "hello.com")
  # payload_request.save
  end
end
