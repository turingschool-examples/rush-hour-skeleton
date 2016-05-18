class PayloadParser

  def parse_json(string)
    JSON.parse(string)
  end

  def populate_urls(payload)
    url = payload["url"]
    Url.create("url": url)
  end

  def populate_references(payload)
    reference = payload["referredBy"]
    Reference.create("reference": reference)
  end

  def populate_request_types(payload)
    request_type = payload["requestType"]
    RequestType.create("request_type": request_type)
  end

  def populate_event_names(payload)
    event_name = payload["eventName"]
    EventName.create("event_name": event_name)
  end

  def populate_user_agents(payload)
    user_agents = UserAgent.parse(payload["userAgents"])
    browser = user_agents.browser
    os = user_agents.operating_system
    UserAgent.create("browser": browser, "os": os)
  end

  def populate_resolutions(payload)
    width = payload["resolutionWidth"]
    height = payload["resolutionHeight"]
    Resolution.create("resolution_width": width, "resolution_height": height)
  end





end
