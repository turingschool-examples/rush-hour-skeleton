require 'useragent'

module PayloadCreator

  def create_new_payload(params, client_identifier)
    parsed_payload = JSON.parse(params["payload"])
    parsed_user_agent = parse_user_agent_info(parsed_payload["userAgent"])

    payload = PayloadRequest.new(
      url: Url.find_or_create_by(address: parsed_payload["url"]),
      requested_at: parsed_payload["requestedAt"],
      responded_in: parsed_payload["respondedIn"],
      referred_by: ReferredBy.find_or_create_by(name: parsed_payload["referredBy"]),
      request_type: RequestType.find_or_create_by(name: parsed_payload["requestType"]),
      parameters: parsed_payload["parameters"],
      event: Event.find_or_create_by(name: parsed_payload["eventName"]),
      user_agent_info: UserAgentInfo.find_or_create_by(parsed_user_agent),
      screen_size: ScreenSize.find_or_create_by(resolution_width: parsed_payload["resolutionWidth"], resolution_height: parsed_payload["resolutionHeight"]),
      ip: Ip.find_or_create_by(address: parsed_payload["ip"]),
      client: Client.find_by(identifier: client_identifier),
      sha: create_sha(parsed_payload)
      )
  end

  def parse_user_agent_info(user_agent_info)
    user_agent_qualities = {}
    user_agent = UserAgent.parse(user_agent_info)
    user_agent_qualities[:browser] = user_agent.browser
    user_agent_qualities[:platform] = user_agent.platform
    user_agent_qualities[:version] = "Windows 8.1"
    user_agent_qualities[:os] = user_agent.os
    user_agent_qualities
  end

end
