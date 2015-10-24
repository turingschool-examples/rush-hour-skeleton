require 'json'
require 'digest'
require 'useragent'

module TrafficSpy
  class JsonParser
    def self.parse_json(payload, source)
      json_payload = JSON.parse(payload)
      url = URL.find_or_create_by({:url => json_payload["url"]})
      event = Event.find_or_create_by({:event_name => json_payload["eventName"]})
      user_agent = Agent.find_or_create_by({:agent => json_payload["userAgent"]})
      ip = Ip.find_or_create_by({:ip => json_payload["ip"]})
      @data = Payload.new(
                         :requested_at => json_payload["requestedAt"],
                         :responded_in => json_payload["respondedIn"],
                         :referred_by => json_payload["referredBy"],
                         :request_type => json_payload["requestType"],
                         :event_id => event.id,
                         :agent_id => user_agent.id,
                         :resolution_width => json_payload["resolutionWidth"],
                         :resolution_height => json_payload["resolutionHeight"],
                         :ip_id => ip.id,
                         :hex_digest => Digest::SHA2.hexdigest(payload.to_s),
                         :source_id => source.id,
                         :url_id => url.id)
     end
     @data
   end
 end
