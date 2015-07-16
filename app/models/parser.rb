class Parser

  def self.parse(payload)
    data = payload[7..-1]
    payload_hash = JSON.parse(data)
    converted = {}
    payload_hash.each do |key, value|
      converted[convert(key).to_sym] = value
    end

    converted
  end

  def self.convert(key)
    key.split(/(?=[A-Z])/).map do |word|
      word.downcase
    end.join("_")
  end

end
