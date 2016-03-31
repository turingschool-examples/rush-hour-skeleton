require 'json'

class PayloadParser
  attr_reader :status, :body

  def initialize(params)
    create_payload_request(params)
  end

  def payload_to_hash(params)
    JSON.parse(params["payload"])
  end

  def create_payload_request(params)
    elements = payload_to_hash(params)


    PayloadRequest.create({
      url_id:          load_url(elements["url"]),
      requested_at:    elements["requestedAt"],
      response_time:   elements["respondedIn"],
      referral_id:     load_referral(elements["referredBy"]),
      request_type_id: load_request_type(elements["requestType"]),
      event_id:        load_event_name(elements["eventName"]),
      user_agent_id:   load_user_agent(elements["userAgent"]),
      ip_id:           load_ip(elements["ip"]),
      client_id:       get_client_id(params["id"]),
      resolution_id:   load_resolution(elements["resolutionWidth"],
                                       elements["resolutionHeight"])
      })

  end

  def load_url(raw_url)

    if raw_url[-1] == '/'
      path = '/'
      root_url = raw_url.chop
    else
      raw_url  = raw_url.split('/')
      path     = "/#{raw_url.pop}"
      root_url = raw_url.join('/')
    end

    url = Url.find_or_create_by(path: path, root_url: root_url)
    url.id
  end

  def load_referral(raw_referral)

    if raw_referral[-1] == '/'
      path = '/'
      root_url = raw_referral.chop
    else
      raw_referral  = raw_referral.split('/')
      path     = "/#{raw_referral.pop}"
      root_url = raw_referral.join('/')
    end

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
                                                  os: usr_agent.os.to_s)
    user_agent.id
  end

  def load_resolution(raw_width, raw_height)
    resolution = Resolution.find_or_create_by(width: raw_width,
                                             height: raw_height)
    resolution.id
  end

  def load_ip(raw_ip)
    ip = Ip.find_or_create_by(address: raw_ip)
    ip.id
  end

  def get_client_id(id)
    # if find doesnt find id need to return error that user unregistered
    client =  Client.find_by(identifier: id)
    return nil if client.nil?
    client.id
  end

end
