require 'json'
require 'pry'
require 'useragent'

module TrafficSpy
  class PayloadParser
    def parse(input)
      payload = JSON.parse(input)
      browser = UserAgent.parse(payload["userAgent"]).browser
      platform = UserAgent.parse(payload["userAgent"]).platform
        payload_headers = {
        :url => payload["url"],
        :requested_at => payload["requestedAt"],
        :responded_in => payload["respondedIn"],
        :referred_by =>  payload["referredBy"],
        :request_type => payload["requestType"],
        :event_name => payload["eventName"],
        :resolution_width => payload["resolutionWidth"],
        :resolution_height => payload["resolutionHeight"],
        :ip => payload["ip"],
        :sha => payload["sha"],
        :browser => browser,
        :platform => platform
      }
    end
  end
end


# def parse(input)
#   if input != "null"
#     JSON.parse(input)
#   else
#     {}
#   end
# end
