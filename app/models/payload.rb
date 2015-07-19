require 'digest/sha1'

class Payload < ActiveRecord::Base
  belongs_to :url
  belongs_to :event
  belongs_to :referrer
  belongs_to :browser
  belongs_to :platform
  belongs_to :request_type

  def self.create_sha(payload)
    if payload != nil
      Digest::SHA1.hexdigest(payload)
    end
  end

  def self.process(site, sha, params_payload)
      parsed_payload = JsonParser.parse(params_payload)
      url = Url.find_or_create_by(path: parsed_payload[:path], site_id: site.id)
      event = Event.find_or_create_by(name: parsed_payload[:event_name])
      referrer = Referrer.find_or_create_by(path: parsed_payload[:referred_by])
      browser = Browser.find_or_create_by(name: parsed_payload[:browser] )
      platform = Platform.find_or_create_by(name: parsed_payload[:platform] )
      request_type = RequestType.find_or_create_by(verb: parsed_payload[:request_type])
      url.payloads.new(resolution_width: parsed_payload[:resolution_width],
        resolution_height: parsed_payload[:resolution_height],requested_at:
        parsed_payload[:requested_at], responded_in: parsed_payload[:responded_in],
        event_id: event.id, referrer_id: referrer.id, browser_id: browser.id,
        platform_id: platform.id, request_type_id: request_type.id, sha: sha)
  end
end
