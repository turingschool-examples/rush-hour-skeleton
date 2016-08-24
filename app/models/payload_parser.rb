class PayloadParser
  def initialize(payload)
    @payload = payload
  end

  def parse
    JSON.parse(replace(@payload))
  end

  def replace(payload)
    substitutions = {"requestedAt" => "requested_at", "respondedIn" => "responded_in", "referredBy" => "referred_by", "requestType" => "request_type", "userAgent" => "user_agent", "resolutionWidth" => "resolution_width", "resolutionHeight" => "resolution_height"}
    substitutions.each_pair { |key, value| payload.gsub!(key, value) }
    payload
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
