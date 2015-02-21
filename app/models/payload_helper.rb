require 'useragent'

class PayloadHelper
  class << self
    def add_payload(identifier, payload_value)
      @identifier = Identifier.where(name: identifier).to_a[0]
      add_to_specific_tables(payload_value)
      add_payload_data(payload_value)
    end

    def add_to_specific_tables(payload_value)
      @agent = Agent.find_or_create_by(browser: parse_user_agent(payload_value)[0], version: parse_user_agent(payload_value)[1], platform: parse_user_agent(payload_value)[2])
      @dimension = Dimension.find_or_create_by(height: payload_value["resolutionHeight"], width: payload_value["resolutionWidth"])
      @event = Event.find_or_create_by(name: payload_value["eventName"])
      @ip = Ip.find_or_create_by(address: payload_value["ip"])
      @referral = Referral.find_or_create_by(url: payload_value["referredBy"])
      @request = Request.find_or_create_by(request_type: payload_value["requestType"])
      @url = Url.find_or_create_by(address: payload_value["url"])
    end

    def parse_user_agent(payload_value)
      ua = UserAgent.parse(payload_value["userAgent"])
      return ua.browser, ua.version, ua.platform
    end

    def add_payload_data(payload_value)
      payload = Payload.create(requested_at: payload_value["requestedAt"], responded_in: payload_value["respondedIn"], parameters: payload_value["parameters"])
      @identifier.payloads << payload
      @agent.payloads << payload
      @dimension.payloads << payload
      @event.payloads << payload
      @ip.payloads << payload
      @referral.payloads << payload
      @request.payloads << payload
      @url.payloads << payload
      payload
    end
  end
end
