module CreateSourcesAndPayloads
  def self.create_source(identifier, root_url)
    Source.create(identifier: "#{identifier}", root_url: "#{root_url}")
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
                          source)
    Payload.create(
      url: Url.create(name: "#{url}"),
      requested_at: "#{requested_at}",
      responded_in: responded_in,
      referred_by: "#{referred_by}",
      request_type: "#{request_type}",
      parameters:[],
      event_name: "#{event_name}",
      user_agent: "#{user_agent}",
      resolution_width: "#{resolution_width}",
      resolution_height:"#{resolution_height}",
      ip: "#{ip}",
      source: source
      )
  end
end