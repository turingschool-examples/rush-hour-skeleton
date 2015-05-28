require 'json'

module TrafficSpy
  class PayloadParser
    def parse(input)
      json_params = input.to_json
      if json_params != "null"
        # require 'pry'; binding.pry
        JSON.parse(json_params)
      else
        {}
      end
    end

    def change_names(payload)
      new_hash = {
        :url => payload[:url],
        :requested_at => payload[:requestedAt],
        :responded_in => payload[:respondedIn],
        :referred_by =>  payload[:referredBy],
        :request_type => payload[:requestType],
        :event_name => payload[:eventName],
        :user_agent => payload[:userAgent],
        :resolution_width => payload[:resolutionWidth],
        :resolution_height => payload[:resolutionHeight],
        :ip => payload[:ip],
        :sha => payload[:sha]
      }
    end
  end
end
