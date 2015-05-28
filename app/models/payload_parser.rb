require 'json'

module TrafficSpy
  class PayloadParser
    def self.parse(input)
      json_params = input.to_json
      JSON.parse(json_params)
    end
  end
end
