module Parser

  def json(string)
    JSON.parse(string)
  end

  def create_resolution(payload)
    parsed = json(payload)
    w = parsed["resolutionWidth"]
    h = parsed["resolutionHeight"]
    Resolution.where("width": w).where("height": h).first_or_create
  end

  def create_user_agent(user_agent)
    parsed_agent = UserAgent.parse(user_agent)
    b = parsed_agent.browser
    p = parsed_agent.platform
    UserAgentB.where("browser": b).where("platform": p).first_or_create
  end

  def create_url(url)
    Url.where("address": url).first_or_create
  end

  def create_referrer(referrer)
    Referrer.where("address": referrer).first_or_create
  end

  def create_request(request)
    Request.where("verb": request).first_or_create
  end

  def create_event(event)
    Event.where("name": event).first_or_create
  end

  def create_ip(ip)
    Ip.where("address": ip).first_or_create
  end

  def parse_payload_request(string)
    payload = json(string)
    requested  = payload["requestedAt"]
    responded  = payload["respondedIn"]
    parameters = payload["parameters"]
    url_id = create_url(payload["url"]).id
    referrer_id = create_referrer(payload["referredBy"]).id
    request_id= create_request(payload["requestType"]).id
    event_id = create_event(payload["eventName"]).id
    user_agent_id = create_user_agent(payload["userAgent"]).id
    resolution_id = create_resolution(payload).id
    ip_id = create_ip(payload["ip"]).id
    # c =   Client.create(payload)

    PayloadRequest.create(
                           "requested_at":  requested,
                           "responded_in":  responded,
                           "parameters":    parameters,
                           "id_url":        url_id,
                           "id_referrer":   referred_id,
                           "id_request":    request_id,
                           "id_event":      event_id,
                           "id_useragent":  user_agent_id,
                           "id_resolution": resolution_id,
                           "id_ip":         ip_id
                          #  "id_client":     c
                          )
  end

end
