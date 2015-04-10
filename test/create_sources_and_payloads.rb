module CreateSourcesAndPayloads
  def self.create_source(identifier, root_url)
    TrafficSpy::Source.create(identifier: "#{identifier}", root_url: "#{root_url}")
  end

  def self.create_payload(url, 
                          requested_at,
                          responded_in,
                          referred_by,
                          request_type,
                          parameters,
                          event_name,
                          user_agent,
                          resolution_width,
                          resolution_height,
                          ip,
                          source_a)
  
    user_agent = ::UserAgent.parse(user_agent)
    TrafficSpy::Payload.create(
      url: TrafficSpy::Url.find_or_create_by(name: "#{url}"),
      requested_at: "#{requested_at}",
      responded_in: responded_in,
      referred_by: "#{referred_by}",
      request_type: "#{request_type}",
      parameters:[],
      event_name: "#{event_name}",
      user_agent: TrafficSpy::UserAgent.find_or_create_by(browser: user_agent.browser, version: user_agent.version, platform: user_agent.platform),
      resolution_width: "#{resolution_width}",
      resolution_height:"#{resolution_height}",
      ip: "#{ip}",
      source: source_a
      )
  end
end