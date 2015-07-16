class Parser

  def self.parse(payload, type=nil)
    if type.nil?
      parse_worker(payload)
      @converted
    else
      parse_worker(payload)
      {type.to_sym => @converted[type.to_sym]}
    end
  end

  def self.parse_worker(payload)
    payload_hash = JSON.parse(payload)
    @converted = {}
    payload_hash.each do |key, value|
      @converted[convert(key).to_sym] = value
    end
  end

  def self.convert(key)
    key.split(/(?=[A-Z])/).map do |word|
      word.downcase
    end.join("_")
  end
end
