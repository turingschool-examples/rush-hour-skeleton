require 'useragent'

class PayloadHelper
  class << self
    def add_to_db(payload_value)
      #Agent.find_or_create_by(browser: parse_user_agent(payload_value)[0], version: parse_user_agent(payload_value)[1], platform: parse_user_agent(payload_value)[2])
      Dimension.find_or_create_by(height: payload_value["resolutionHeight"], width: payload_value["resolutionWidth"])
      Event.find_or_create_by(name: payload_value["eventName"])
      Ip.find_or_create_by(address: payload_value["ip"])
      Referral.find_or_create_by(url: payload_value["referredBy"])
      Request.find_or_create_by(request_type: payload_value["requestType"])
      Url.find_or_create_by(address: payload_value["url"])
    end

    def parse_user_agent(payload_value)
      ua = UserAgent.parse(payload_value["userAgent"])
      return ua.browser, ua.version, ua.platform
    end
  end
end
