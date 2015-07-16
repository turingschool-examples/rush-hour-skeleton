class Parser

  def self.parse(payload, type=nil)
    data = payload
    # [8..-1]
    if type.nil?
      payload_hash = JSON.parse(data)
      converted = {}
      payload_hash.each do |key, value|
        converted[convert(key).to_sym] = value
      end
      converted
    else
      payload_hash = JSON.parse(data)
      converted_t = {}
      payload_hash.each do |key, value|
        converted_t[convert(key).to_sym] = value
      end

      {type.to_sym => converted_t[type.to_sym]}
    end
  end

  def self.convert(key)
    key.split(/(?=[A-Z])/).map do |word|
      word.downcase
    end.join("_")
  end
end
