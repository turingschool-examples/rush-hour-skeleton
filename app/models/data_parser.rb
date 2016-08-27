require 'json'

class DataParser
  attr_reader :raw_data

  def initialize(raw_data)
    @raw_data = raw_data
  end

  def new_keys
    { "requestedAt"=>"requested_at",
      "respondedIn"=>"responded_in",
      "referredBy"=>"referred_by",
      "requestType"=>"request_type",
      "userAgent"=>"u_agent",
      "resolutionWidth"=>"resolution_width",
      "resolutionHeight"=>"resolution_height",
      "rootUrl"=>"root_url"
    }
  end

  def parsed_payload
    JSON.parse(raw_data)
  end

  def formatted_payload
    parsed_payload.map {|key, value| [new_keys[key] || key, value]}.to_h
  end

  def formatted_client
    raw_data.map {|key, value| [new_keys[key] || key, value]}.to_h
  end

end
