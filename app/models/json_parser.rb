class JsonParser
  def self.parse(payload)
    parsed_payload = JSON.parse(payload)

    formatted_payload = {}
    formatted_payload[:path] = parsed_payload["url"]
    formatted_payload[:requested_at] = parsed_payload["requestedAt"]
    formatted_payload[:responded_in] = parsed_payload["respondedIn"]
    formatted_payload[:referred_by] = parsed_payload["referredBy"]
    formatted_payload[:request_type] = parsed_payload["requestType"]
    formatted_payload[:event_name] = parsed_payload["eventName"]
    formatted_payload[:resolution_width] = parsed_payload["resolutionWidth"]
    formatted_payload[:resolution_height] = parsed_payload["resolutionHeight"]

    formatted_payload[:browser] = UserAgent.parse(
      parsed_payload["userAgent"]).browser
    formatted_payload[:platform] = UserAgent.parse(
      parsed_payload["userAgent"]).platform

    formatted_payload
  end
end
