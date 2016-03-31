require 'json'

class PayloadParser
  attr_reader :status, :body

  def initialize(params)
    identifier = params["id"]
    raw_payload = payload_to_hash(params)
    create_status_and_body(raw_payload, identifier)
    require 'pry'; binding.pry
  end

  def payload_to_hash(params)
    JSON.parse(params["payload"])
  end

  def create_payload_request(raw_payload, identifier)
    # require 'pry'; binding.pry
    PayloadRequest.new({
      url_id:          load_url(raw_payload["url"]),
      requested_at:    raw_payload["requestedAt"],
      response_time:   raw_payload["respondedIn"],
      referral_id:     load_referral(raw_payload["referredBy"]),
      request_type_id: load_request_type(raw_payload["requestType"]),
      event_id:        load_event_name(raw_payload["eventName"]),
      user_agent_id:   load_user_agent(raw_payload["userAgent"]),
      ip_id:           load_ip(raw_payload["ip"]),
      client_id:       get_client_id(identifier),
      resolution_id:   load_resolution(raw_payload["resolutionWidth"],
                                       raw_payload["resolutionHeight"])
      })
  end

  def url_parser(raw_url)
    if raw_url[-1] == '/'
      path = '/'
      root_url = raw_url.chop
    else
      raw_url  = raw_url.split('/')
      path     = "/#{raw_url.pop}"
      root_url = raw_url.join('/')
    end
    [path, root_url]
  end

  def load_url(raw_url)
    path, root_url = url_parser(raw_url)
    url = Url.find_or_create_by(path: path, root_url: root_url)
    url.id
  end

  def load_referral(raw_referral)
    path, root_url = url_parser(raw_referral)
    ref = Referral.find_or_create_by(path: path, root_url: root_url)
    ref.id
  end

  def load_request_type(verb)
    request = RequestType.find_or_create_by(verb: verb)
    request.id
  end

  def load_event_name(name)
    event_name = Event.find_or_create_by(name: name)
    event_name.id
  end

  def load_user_agent(raw_usr_agent)
    usr_agent  = UserAgentParser.parse raw_usr_agent
    user_agent = UserAgent.find_or_create_by(browser: usr_agent.to_s,
                                             os:      usr_agent.os.to_s)
    user_agent.id
  end

  def load_resolution(raw_width, raw_height)
    resolution = Resolution.find_or_create_by(width:  raw_width,
                                              height: raw_height)
    resolution.id
  end

  def load_ip(raw_ip)
    ip = Ip.find_or_create_by(address: raw_ip)
    ip.id
  end

  def get_client_id(id)
    client =  Client.find_by(identifier: id)
    return nil if client.nil?
    client.id
  end

  def create_status_and_body(params, identifier)
    if !Client.exists?(identifier: identifier)
      application_not_registered
    elsif params.nil?
      require 'pry'; binding.pry
      missing_payload
    else
      payload = create_payload_request(params, identifier)
      if PayloadRequest.exists?(
        url_id:          payload.url_id,
        requested_at:    payload.requested_at,
        response_time:   payload.response_time,
        referral_id:     payload.referral_id,
        request_type_id: payload.request_type_id,
        event_id:        payload.event_id,
        user_agent_id:   payload.user_agent_id,
        resolution_id:   payload.resolution_id,
        ip_id:           payload.ip_id)
        already_received_request
      elsif payload.save
        payload_successful
      else
        attributes_missing
      end
    end
  end

  def attributes_missing
    @status = 400
    @body = "missing one or more attributes"
  end

  def already_received_request
    @status = 403
    @body   = "Payload has already been received.\n"
  end

  def payload_successful
    @status = 200
    @body   = "Payload successfully created.\n"
  end

  def missing_payload
    @status = 400
    @body   = "No payload present.\n"
  end

  def application_not_registered
    @status = 403
    @body   = "Client does not exist.\n"
  end

end
