class PayloadParser
  attr_reader :payload,
              :url

  def initialize(input)
    @payload = JSON.parse(input[:payload])
    @url = {}
  end

  def parse
    snake_case = convert_keys_to_snakecase(payload)
    convert_keys_to_symbols(snake_case)
  end

  def url
    parse.select {|k, v| k.eql?(:url)}
  end

  private

  def convert_keys_to_symbols(hash_with_string_keys)
    hash_with_string_keys.reduce({}) do |symbolized, (k, v)|
      symbolized[k.to_sym] = v;
      symbolized
    end
  end

  def convert_keys_to_snakecase(hash_with_camel_case_keys)
    hash_with_camel_case_keys.reduce({}) do |snaked, (k, v)|
      snaked[snake_case(k)] = v
      snaked
    end
  end

  def snake_case(string)
    string.split(/(?=[A-Z])/).map do |word|
      word.downcase
    end.join("_")
  end

end
