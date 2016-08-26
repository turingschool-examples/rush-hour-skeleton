require 'json'

module DataParser
  def new_keys
    { "requestedAt"=>"requested_at",
      "respondedIn"=>"responded_in",
      "referredBy"=>"referred_by",
      "requestType"=>"request_type",
      "userAgent"=>"u_agent",
      "resolutionWidth"=>"resolution_width",
      "resolutionHeight"=>"resolution_height"
    }
  end

  def parsed(raw_payload)
    JSON.parse(raw_payload)
  end

  def formatted_payload(raw_payload)
    parsed(raw_payload).map {|key, value| [new_keys[key] || key, value]}.to_h
  end

end
