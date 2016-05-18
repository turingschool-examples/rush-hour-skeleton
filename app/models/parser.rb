module Parser

  def json(string)
    JSON.parse(string)
  end

  def parse_resolution(string)
    payload = json(string)
    w = payload["resolutionWidth"]
    h = payload["resolutionHeight"]
    Resolution.create(
                        "width": w,
                        "height": h
                      )
  end

  def parse_user_agent(thing)
    payload = json(thing)
    string = payload["userAgent"]
    user_agent = UserAgent.parse(string)
    b = user_agent.browser
    v = user_agent.version
    p = user_agent.platform
    UserAgentB.create(
                        "browser":  b,
                        "version":  v,
                        "platform": p
                      )
  end

  def parse_table_request(string)
    payload = json(string)
    r_a = payload["requestedAt"]
    r_i = payload["respondedIn"]
    p =   payload["parameters"]
    u =   Url.create(payload["url"]).id
    r_b = Referrers.create(payload["referredBy"]).id
    r_q = Requests.create(payload["requestType"]).id
    e =   Events.create(payload["eventName"]).id
    u =   parse_user_agent(payload).id
    r =   parse_resolution(payload).id
    ip =  Ip.create(payload[:ip]).id
    c =   Client.create(payload)

    PayloadRequest.create(
                           "requested_at":  r_a
                           "responded_in":  r_i
                           "parameters":    p
                           "id_url":        u
                           "id_referrer":   r_b
                           "id_request":    r_q
                           "id_event":      e
                           "id_useragent":  u
                           "id_resolution": r
                           "id_ip":         ip
                           "id_client":     c
                          )

  end

end
