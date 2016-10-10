class PayloadBuilder
  def self.build(payload, identifier)
    event = build_event(payload)
    referral = build_referral(payload)
    request = build_request(payload)
    resolution = build_resolution(payload)
    url = build_url(payload)
    user_agent_stat = build_user_agent_stat(payload)
    visitor = build_visitor(payload)

    payload = Payload.new( requested_at: payload[:requested_at],
                           responded_in: payload[:responded_in],
                           url_id: url.id,
                           referral_id: referral.id,
                           request_id: request.id,
                           event_id: event.id,
                           user_agent_stat_id: user_agent_stat.id,
                           resolution_id: resolution.id,
                           visitor_id: visitor.id,
                           client_id: client.id )
  end

  def self.build_event(payload)
    Event.find_or_create_by(event_name: payload[:event_name])
  end

  def self.build_referral(payload)
    Referral.find_or_create_by(source: payload[:referred_by])
  end

  def self.build_request(payload)
    Request.find_or_create_by(request_type: payload[:request_type])
  end

  def self.build_resolution(payload)
    Resolution.find_or_create_by(height: payload[:resolution_height], width: payload[:resolution_width])
  end

  def self.build_url(payload)
    Url.find_or_create_by(url_address: payload[:url])
  end

  def self.build_user_agent_stats(payload)
    UserAgentStat.find_or_create_by(browser: payload[:browser], operating_system: payload[:operating_system])
  end

  def self.build_visitor(payload)
    Visitor.find_or_create_by(ip: payload[:ip])
  end
end
