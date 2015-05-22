class PayloadParser < ActiveRecord::Base

  def self.parse(data, composite_key = [])
    address_id      = Address.find_or_create_by(ip: data[:ip]).id
    agent_id        = Agent.find_or_create_by(user_agent: data[:userAgent]).id
    client_id       = Client.find_or_create_by(identifier: data[:identifier]).id
    event_id        = Event.find_or_create_by(event_name: data[:eventName]).id
    referer_id      = Referer.find_or_create_by(referred_by: data[:referredBy]).id
    request_id      = Request.find_or_create_by(request_type: data[:requestType]).id
    resolution_id   = Resolution.find_or_create_by(resolution_height: data[:resolutionHeight], resolution_width: data[:resolutionWidth]).id
    tracked_site_id = TrackedSite.find_or_create_by(url: data[:url]).id

    if address_id  == nil
      composite_key = nil
    else
      data.each_value do |value|
        composite_key << value
      end
      composite_key = composite_key.join
    end

    payload_data = {
       parameters:      data[:parameters],
       responded_in:    data[:respondedIn],
       requested_at:    data[:requestedAt],
       address_id:      address_id,
       agent_id:        agent_id,
       client_id:       client_id,
       event_id:        event_id,
       referer_id:      referer_id,
       request_id:      request_id,
       resolution_id:   resolution_id,
       tracked_site_id: tracked_site_id,
       composite_key:   composite_key
        }
  end

end
