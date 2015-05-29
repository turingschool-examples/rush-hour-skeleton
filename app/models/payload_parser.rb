require 'json'
require 'pry'

module TrafficSpy
  class PayloadParser
    def parse(input)
      payload = JSON.parse(input)
        payload_headers = {
        :url => payload["url"],
        :requested_at => payload["requestedAt"],
        :responded_in => payload["respondedIn"],
        :referred_by =>  payload["referredBy"],
        :request_type => payload["requestType"],
        :event_name => payload["eventName"],
        :user_agent => payload["userAgent"],
        :resolution_width => payload["resolutionWidth"],
        :resolution_height => payload["resolutionHeight"],
        :ip => payload["ip"],
        :sha => payload["sha"]
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
