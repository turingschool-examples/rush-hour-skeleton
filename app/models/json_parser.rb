class JsonParser
  def self.parse(payload)
    parsed_payload = JSON.parse(payload)
    new_keys = JSON.parse(payload)

    new_keys.keys.each do |key|
      new_keys[key] = key.chars.map do |char|
        if char == char.upcase
          char.insert(0, "_")
        else
          char
        end
      end.join.downcase
    end

    payload_with_user_agent = Hash[parsed_payload.map { |k,v| [new_keys[k].to_sym, v]}]
    get_browser_and_platform(payload_with_user_agent)
  end

  def self.get_browser_and_platform(payload)
    user_agent = parse_user_agent(payload[:user_agent])
    payload.delete(:user_agent)
    payload[:browser] = user_agent.browser
    payload[:platform] = user_agent.platform
    payload
  end

  def self.parse_user_agent(user_agent)
    UserAgent.parse(user_agent)
  end


end
