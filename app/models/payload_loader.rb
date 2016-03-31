class PayloadLoader

  def create_payload_request(raw_payload, identifier)
    PayloadRequest.new({
      url_id:          load_url(raw_payload["url"]),
      # url:          load_url(raw_payload["url # take off .id line of every method
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
    # look into URI
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
    parsed_user_agent = UserAgentParser.parse raw_usr_agent
    user_agent_object = UserAgent.find_or_create_by(browser: parsed_user_agent.to_s,
                                                    os:      parsed_user_agent.os.to_s)
    user_agent_object.id
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


end
