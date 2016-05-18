class PayloadParser
  attr_reader :payload

  def initialize(payload)
    @payload = JSON.parse(payload)
    populate_payload_requests
  end
  #initialize with payload as ivar instead of passing it
  #over and over again

  # def parse_json(string)
  #   JSON.parse(string)
  # end

  def populate_urls
    url = payload["url"]
    Url.where(url: url).first_or_create
  end

  def populate_references
    reference = payload["referredBy"]
    Reference.where(reference: reference).first_or_create
  end

  def populate_request_types
    request_type = payload["requestType"]
    RequestType.where(request_type: request_type).first_or_create
  end

  def populate_event_names
    event_name = payload["eventName"]
    EventName.where(event_name: event_name).first_or_create
  end

  def populate_software_agents
    user_agents = UserAgent.parse(payload["userAgent"])
    browser = user_agents.browser
    os = user_agents.os
    SoftwareAgent.where(browser: browser, os: os).first_or_create
  end

  def populate_resolutions
    width = payload["resolutionWidth"]
    height = payload["resolutionHeight"]
    Resolution.where(resolution_width: width, resolution_height: height).first_or_create
  end

  def populate_ip_addresses
    IpAddress.where(ip_address: payload["ip"]).first_or_create
  end

 #method that creates payload will call all these other methods
 def populate_payload_requests
   PayloadRequest.create({
    url_id: populate_urls.id,
    requested_at: payload["requestedAt"],
    responded_in: payload["respondedIn"],
    reference_id: populate_references.id,
    request_type_id: populate_request_types.id,
    parameters: payload["parameters"],
    event_name_id: populate_event_names.id,
    software_agent_id: populate_software_agents.id,
    resolution_id: populate_resolutions.id,
    ip_address_id: populate_ip_addresses.id
   })
 end

end
