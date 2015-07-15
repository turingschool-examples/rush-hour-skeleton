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

    Hash[parsed_payload.map { |k,v| [new_keys[k].to_sym, v]}]
  end
end
