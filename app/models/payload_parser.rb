class PayloadParser
  attr_reader :payload
  def initialize(payload)
    @payload = payload
  end

  def parse
    parsed = JSON.parse(@payload)

    @payload = replace_keys(parsed)
    populate(@payload)
  end

  def replace_keys(json_hash)
    substitutions = {"requestedAt" => "requested_at", "respondedIn" => "responded_in", "referredBy" => "referred_by", "requestType" => "request_type", "userAgent" => "system_information", "resolutionWidth" => "resolution_width", "resolutionHeight" => "resolution_height"}
    result = {}
    json_hash.each_pair do |json_key, value|
      if substitutions.keys.include?(json_key)
        result[ substitutions[json_key] ] = value
      else
        result[json_key] = value
      end
    end
    format_agent(result)
  end

  def format_agent(payload)
    agent = UserAgent.parse(payload[:user_agent])

    result = {}
    @payload.each_pair do |key, value|
      if key == "user_agent"
        result[:browser] = agent.browser
        result[:operating_system] = agent.os
      else
        result[key] = value
      end
    end
    @payload = result
  end

  def populate(payload)
    ip = Ip.find_or_create_by(address: payload["ip"])
    referral = Referral.find_or_create_by(referred_by: payload["referred_by"])
    request_type = RequestType.find_or_create_by(http_verb: payload["request_type"])
    resolution = Resolution.find_or_create_by(height: payload["resolution_height"], width: payload["resolution_width"])
    url = Url.find_or_create_by(web_address: payload["url"])
    user_using = UserUsing.find_or_create_by(browser: payload["browser"], operating_system: payload["operating_system"])

    payload_request = PayloadRequest.create(requested_at: payload["requested_at"],
      responded_in: payload["responded_in"],
      resolution_id: resolution.id,
      user_using_id: user_using.id,
      referral_id: referral.id,
      ip_id: ip.id,
      request_type_id: request_type.id,
      url_id: url.id)
  end
end
#
# payload = '{
#   "url":"http://jumpstartlab.com/blog",
#   "requestedAt":"2013-02-16 21:38:28 -0700",
#   "respondedIn":37,
#   "referredBy":"http://jumpstartlab.com",
#   "requestType":"GET",
#   "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#   "resolutionWidth":"1920",
#   "resolutionHeight":"1280",
#   "ip":"63.29.38.211"
# }'
