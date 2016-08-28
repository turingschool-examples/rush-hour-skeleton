class PayloadParser

  def initialize(payload)
    @payload = payload[:payload]
  end

  def parse
    return {} if @payload.nil?
    parsed = JSON.parse(@payload)
    @payload = replace_keys(parsed)
  end

  def replace_keys(json_result)
    substitutions = {:requestedAt => :requested_at, :respondedIn => :responded_in, :referredBy => :referred_by, :requestType => :request_type, :userAgent => :system_information, :resolutionWidth => :resolution_width, :resolutionHeight => :resolution_height}
    result = {}
    json_result.each_pair do |json_key, value|
      if substitutions.keys.include?(json_key.to_sym)
        result[ substitutions[json_key.to_sym] ] = value
      else
        result[json_key.to_sym] = value
      end
    end
    format_agent(result)
  end

  def format_agent(payload)
    agent = UserAgent.parse(payload[:system_information])

    result = {}
    payload.each_pair do |key, value|
      if key == :system_information
        result[:browser] = agent.browser
        result[:operating_system] = agent.os
      else
        result[key] = value
      end
    end
    @payload = result
  end


end
