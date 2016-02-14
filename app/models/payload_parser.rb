class PayloadParser
  def parse_payload(params)
    return [400, "Please submit a payload."] if params["payload"].nil?
    payload = JSON.parse(params["payload"])
    client = Client.find_by(identifier: params["identifier"])
    return [403, "You can only track URLs that belong to you."] if client.nil?
    new_payload = create_payload(client, payload)
    if new_payload.save
      [200, ""]
    elsif new_payload.errors.full_messages.include? ("Requested at has already been taken")
      [403, "You have already submitted this payload."]
    end

  end

  def create_payload(client, payload)
    Payload.new(
        requested_at:     payload["requestedAt"],
        response_time:    payload["respondedIn"],
        client_id:        client.id,
        request_type:     RequestType.where(verb: payload["requestType"]).first_or_create,
        refer:            Refer.where(address: payload["referredBy"]).first_or_create,
        event:            Event.where(name: payload["eventName"]).first_or_create,
        user_environment: UserEnvironment.where(browser: get_browser(payload["userAgent"]), os: get_os(payload["userAgent"])).first_or_create,
        ip:               Ip.where(address: payload["ip"]).first_or_create,
        resolution:       Resolution.where(width: payload["resolutionWidth"], height: payload["resolutionHeight"]).first_or_create,
        url:              Url.where(address: payload["url"]).first_or_create
    )
  end

  def get_browser(user_agent_string)
    UserAgent.parse(user_agent_string).browser
  end

  def get_os(user_agent_string)
    UserAgent.parse(user_agent_string).os
  end
end
