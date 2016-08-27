class DataParser
  attr_reader :payload,
              :client_identifier

  def initialize(params)
    @payload = params["payload"]
    @client_identifier = params["identifier"]
  end

  def parse
    JSON.parse(payload)
  end

  def url_exists?
    !(Url.find_by(address: parse["url"])).nil?
  end

  def create_url_return_id
    Url.create(address: parse["url"]).id
  end

  def return_existing_url_id
    Url.find_by(address: parse["url"]).id
  end

  def url_id
    url_exists? ? return_existing_url_id : create_url_return_id
  end

  def source_exists?
    !(Source.find_by(address: parse["referredBy"])).nil?
  end

  def create_source_return_id
    Source.create(address: parse["referredBy"]).id
  end

  def return_existing_source_id
    Source.find_by(address: parse["referredBy"]).id
  end

  def source_id
    source_exists? ? return_existing_source_id : create_source_return_id
  end

  def request_type_exists?
    !(RequestType.find_by(verb: parse["requestType"])).nil?
  end

  def create_request_type_return_id
    RequestType.create(verb: parse["requestType"]).id
  end

  def return_existing_request_type_id
    RequestType.find_by(verb: parse["requestType"]).id
  end

  def request_type_id
    request_type_exists? ? return_existing_request_type_id : create_request_type_return_id
  end

  def ip_address_exists?
    !(IpAddress.find_by(address: parse["ip"])).nil?
  end

  def create_ip_address_return_id
    IpAddress.create(address: parse["ip"]).id
  end

  def return_existing_ip_address_id
    IpAddress.find_by(address: parse["ip"]).id
  end

  def ip_address_id
    ip_address_exists? ? return_existing_ip_address_id : create_ip_address_return_id
  end

  def u_agent_exists?
    u_agent = UserAgent.new(parse["userAgent"])
    !(UAgent.where(browser: u_agent.name.to_s, operating_system: u_agent.os)).empty?
  end

  def create_u_agent_return_id
    u_agent = UserAgent.new(parse["userAgent"])
    UAgent.create(browser: u_agent.name.to_s, operating_system: u_agent.os).id
  end

  def return_existing_u_agent_id
    u_agent = UserAgent.new(parse["userAgent"])
    UAgent.where(browser: u_agent.name.to_s, operating_system: u_agent.os).first.id
  end

  def u_agent_id
    u_agent_exists? ? return_existing_u_agent_id : create_u_agent_return_id
  end

  def screen_resolution_exists?
    !(ScreenResolution.where(width: parse["resolutionWidth"], height: parse["resolutionHeight"])).empty?
  end

  def create_screen_resolution_return_id
    ScreenResolution.create(width: parse["resolutionWidth"], height: parse["resolutionHeight"]).id
  end

  def return_existing_screen_resolution_id
    ScreenResolution.where(width: parse["resolutionWidth"], height: parse["resolutionHeight"]).first.id
  end

  def screen_resolution_id
    screen_resolution_exists? ? return_existing_screen_resolution_id : create_screen_resolution_return_id
  end

  # def client_identifer
  #   request_path.split("/")[2]
  # end

  def client_id
    client = Client.find_by("identifier" => client_identifier)
    client.nil? ? nil : client.id
  end

  def parse_payload
    { "url_id" => url_id,
      "requested_at" => DateTime.parse(parse["requestedAt"]),
      "responded_in" => parse["respondedIn"],
      "source_id" => source_id,
      "request_type_id" => request_type_id,
      "u_agent_id" => u_agent_id,
      "screen_resolution_id" => screen_resolution_id,
      "ip_address_id" => ip_address_id,
      "client_id" => client_id
    }
  end

end
