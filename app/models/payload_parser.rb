class PayloadParser
  def parse_payload(params)
    payload = JSON.parse(params["payload"])

    client = Client.find_by(identifier: params["identifier"])

    Payload.create(
        requested_at:     payload["requestedAt"],
        response_time:    payload["respondedIn"],
        client_id:        client.id,
        request_type:     RequestType.where(verb: payload["requestType"]).first_or_create,
        refer:            Refer.where(address: payload["referredBy"]).first_or_create,
        event:            Event.where(name: payload["eventName"]).first_or_create,
        user_environment: UserEnvironment.where(browser: get_browser(payload["userAgent"]), os: get_os(payload["userAgent"])).first_or_create,
        ip:               Ip.where(address: payload["ip"]).first_or_create,
        resolution:       Resolution.where(width: payload["resolutionWidth"], height: payload["resolutionHeight"]).first_or_create,
        url:               Url.where(address: payload["url"]).first_or_create
    )
  end

  def get_browser(user_agent_string)
    UserAgent.parse(user_agent_string).browser
  end

  def get_os(user_agent_string)
    UserAgent.parse(user_agent_string).os
  end

 #
 #  "url"=>"http://jumpstartlab.com/blog",
 # "requestedAt"=>"2013-02-16 21:38:28 -0700",
 # "respondedIn"=>37,
 # "referredBy"=>"http://jumpstartlab.com",
 # "requestType"=>"GET",
 # "parameters"=>["this"],
 # "eventName"=>"socialLogin",
 # "userAgent"=>"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
 # "resolutionWidth"=>"1920",
 # "resolutionHeight"=>"1280",
 # "ip"=>"63.29.38.211"}
end

# 400 "Please submit a payload."
# 403 "You have already submitted this payload."
# 403 "You can only track URLs that belong to you."
