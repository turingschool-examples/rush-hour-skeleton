require 'useragent'

class PayloadParser
  attr_reader :payload,
              :url,
              :screen_resolution,
              :event,
              :browser,
              :operating_system

  def initialize(input)
    return nil if input['payload'].nil?
    @payload           = parse(input['payload'])
    @url               = {
      url:          payload[:url],
      request_type: payload[:request_type],
      referred_by:  payload[:referred_by],
      responded_in: payload[:responded_in]
    }
    @screen_resolution = {
      width:  payload[:resolution_width],
      height: payload[:resolution_height]
    }
    @event             = {
      name:         payload[:event_name],
      requested_at: DateTime.parse(payload[:requested_at]),
    }
    @browser           = {
      name: UserAgent.parse(payload[:user_agent]).browser
    }
    @operating_system  = {
      name: UserAgent.parse(payload[:user_agent]).platform
    }
  end

  private

  def parse(input)
    snake_case = convert_keys_to_snakecase(JSON.parse(input))
    convert_keys_to_symbols(snake_case)
  end

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
