class PayloadBuilder
  def self.build(payload, identifier)
    event = build_event(payload)
    referral = build_referral(payload)
    request = build_request(payload)
    resolution = build_resolution(payload)
    url = build_url(payload)
    user_agent_stat = build_user_agent_stats(payload)
    visitor = build_visitor(payload)
    client = find_client(identifier)

    Payload.where( requested_at: payload[:requested_at].to_datetime,
                           responded_in: payload[:responded_in],
                           url_id: url.id,
                           referral_id: referral.id,
                           request_id: request.id,
                           event_id: event.id,
                           user_agent_stat_id: user_agent_stat.id,
                           resolution_id: resolution.id,
                           visitor_id: visitor.id,
                           client_id: client.id ).first_or_initialize
  end

  def self.build_event(payload)
    Event.where(event_name: payload[:event_name]).first_or_create
  end

  def self.build_referral(payload)
    Referral.where(source: payload[:referred_by]).first_or_create
  end

  def self.build_request(payload)
    Request.where(request_type: payload[:request_type]).first_or_create
  end

  def self.build_resolution(payload)
    Resolution.where(height: payload[:resolution_height], width: payload[:resolution_width]).first_or_create
  end

  def self.build_url(payload)
    Url.where(url_address: payload[:url]).first_or_create
  end

  def self.build_user_agent_stats(payload)
    user_agent = UserAgent.parse(payload[:user_agent])
    browser = payload[:browser] || user_agent.browser
    operating_system = payload[:operating_system] || user_agent.platform
    UserAgentStat.where(browser: browser, operating_system: operating_system).first_or_create
  end

  def self.build_visitor(payload)
    Visitor.where(ip: payload[:ip]).first_or_create
  end

  def self.find_client(identifier)
    Client.find_by(identifier: identifier)
  end
end
