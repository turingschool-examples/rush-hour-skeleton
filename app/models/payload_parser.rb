require 'useragent'

class PayloadParser
  attr_reader :payload,
              :url

  def initialize(input)
    @payload = parse(input[:payload])
    @url     = {}
  end

  def parse(input)
    snake_case = convert_keys_to_snakecase(JSON.parse(input))
    convert_keys_to_symbols(snake_case)
  end

  def url
    { url: payload[:url] }
  end

  def screen_resolution
    { width: payload[:resolution_width], height: payload[:resolution_height] }
  end

  def event
    { name: payload[:event_name], requested_at: payload[:requested_at], responded_in: payload[:responded_in] }
  end

  # def browser
  #   { name: UserAgent.parse(payload[:user_agent]).browser }
  # end

  def operating_system
    binding.pry
    { name: UserAgent.parse(payload[:user_agent]).operating_system }
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
