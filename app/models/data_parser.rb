class DataParser
  attr_reader :payload

  def initialize(data)
    @payload = parsed_request(data)
    @sha = Digest::SHA256.digest(payload.to_s)
  end

  def parsed_request(request)
    JSON.parse(request)
  end

  def parse_payload(identifier)
   url             = Url.find_or_create_by(root: parsed_root, path: parsed_path)
   request_type    = RequestType.find_or_create_by(verb:payload["requestType"])
   resolution      = Resolution.find_or_create_by(height:payload["resolutionHeight"],
                                                  width:payload["resolutionWidth"])
   referral        = Referral.find_or_create_by(name:payload["referredBy"])
   user_agent_device = UserAgentDevice.find_or_create_by(os: parsed_os, browser: parsed_browser)
   ip              = Ip.find_or_create_by(ip_address:payload["ip"])
   client          = Client.find_by(identifier: identifier)
   responded_in    = payload["respondedIn"]
   requested_at    = payload["requestedAt"]
   payload_request = PayloadRequest.create(url: url, requested_at: requested_at,
                     responded_in: responded_in, referral_id: referral.id,
                     request_type: request_type, user_agent_device_id: user_agent_device.id,
                     resolution: resolution, ip: ip, sha: @sha, client_id: client.id)

  end

  def parsed_root
   URI.parse(payload["url"]).host
  end

  def parsed_path
   URI.parse(payload["url"]).path
  end

  def parsed_os
   UserAgent.parse(payload["userAgent"]).platform
  end

  def parsed_browser
   UserAgent.parse(payload["userAgent"]).browser
  end
end
