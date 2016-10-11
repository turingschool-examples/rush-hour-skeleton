module PayloadParser
  extend self

  def parser(params)
    parsed_hash = JSON.parse(params)
    build_ruby_hash(parsed_hash)
  end

  def build_ruby_hash(parsed_hash)
    key_translator = { "url"=>:url,
                       "requestedAt"=>:requested_at,
                       "respondedIn"=>:responded_in,
                       "referredBy"=>:referred_by,
                       "requestType"=>:request_type,
                       "eventName"=>:event_name,
                       "userAgent"=>:user_agent,
                       "resolutionWidth"=>:resolution_width,
                       "resolutionHeight"=>:resolution_height,
                       "ip"=>:ip }

    parsed_hash.map { |key, value|  [key_translator[key], value] }.to_h
  end
end
