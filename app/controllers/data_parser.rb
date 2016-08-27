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

  def parse_payload
    { "url_id" => url_id,
      "requested_at" => parse["requestedAt"],
      "responded_in" => parse["respondedIn"]
    }
  end

end
