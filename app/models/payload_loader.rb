require 'uri'

class PayloadLoader

  def create_payload_request(raw_payload, identifier)
    PayloadRequest.new({
      url:           load_url(raw_payload["url"]),
      requested_at:  raw_payload["requestedAt"],
      response_time: raw_payload["respondedIn"],
      referral:      load_referral(raw_payload["referredBy"]),
      request_type:  load_request_type(raw_payload["requestType"]),
      event:         load_event_name(raw_payload["eventName"]),
      user_agent:    load_user_agent(raw_payload["userAgent"]),
      ip:            load_ip(raw_payload["ip"]),
      client:        get_client_id(identifier),
      resolution:    load_resolution(raw_payload["resolutionWidth"],
                                    raw_payload["resolutionHeight"])
      })
  end

  def url_parser(raw_url)
    uri = URI(raw_url)
    path = uri.path
    root_url = [uri.scheme, uri.host].join("://")
    [path, root_url]
  end

  def load_url(raw_url)
    path, root_url = url_parser(raw_url)
    Url.find_or_create_by(path: path, root_url: root_url)
  end

  def load_referral(raw_referral)
    path, root_url = url_parser(raw_referral)
    Referral.find_or_create_by(path: path, root_url: root_url)
  end

  def load_request_type(verb)
    RequestType.find_or_create_by(verb: verb)
  end

  def load_event_name(name)
    Event.find_or_create_by(name: name)
  end

  def load_user_agent(raw_usr_agent)
    parsed_user_agent = UserAgentParser.parse raw_usr_agent
    UserAgent.find_or_create_by(browser: parsed_user_agent.to_s,
                                os:      parsed_user_agent.os.to_s)
  end

  def load_resolution(raw_width, raw_height)
    Resolution.find_or_create_by(width:  raw_width,
                                 height: raw_height)
  end

  def load_ip(raw_ip)
    Ip.find_or_create_by(address: raw_ip)
  end

  def get_client_id(id)
    client =  Client.find_by(identifier: id)
    return nil if client.nil?
    client
  end
end
