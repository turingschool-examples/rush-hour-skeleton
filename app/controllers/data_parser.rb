class DataParser
  attr_reader :payload

  def initialize(payload)
    @payload = payload
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

  def parse_payload
    { "url_id" => url_id,
      "requested_at" => parse["requestedAt"],
      "responded_in" => parse["respondedIn"],
      "source_id" => source_id,
      "request_type_id" => request_type_id,
      "ip_address_id" => ip_address_id
    }
  end

end
