require 'json'
require 'digest'

class JsonParser
  def self.parse_json(payload, source)
    json_payload = JSON.parse(payload)
    @data = TrafficSpy::Payload.new(:url => json_payload["url"],
                       :requested_at => json_payload["requestedAt"],
                       :responded_in => json_payload["respondedIn"],
                       :event_name => json_payload["eventName"],
                       :user_agent => json_payload["userAgent"],
                       :resolution_width => json_payload["resolutionWidth"],
                       :resolution_height => json_payload["resolutionHeight"],
                       :ip => json_payload["ip"],
                       :hex_digest => Digest::SHA2.hexdigest(payload.to_s),
                       :source_id => source.id)
                     end
                     @data
                   end
