require 'user_agent_parser'

class PayloadAnalyzer

  def parse(raw_payload)
    # incoming_keys = [:requestType, :userAgent, :resolutionWidth, :resolutionHeight]
    # user_agent = UserAgentParser.parse(raw_payload[:userAgent])
    # os = user_agent.os
    # browser = user_agent.to_s
    # resolution = resolution_parse(raw_payload)
    # verb = raw_payload[:requestType]
    # formatted_payload = {:request_type => verb, :os => os, :browser => browser, :screen_resolution => resolution}
    # formatted_payload.merge!(raw_payload)
    # incoming_keys.each do |key|
    #   formatted_payload.delete(key)
    # end
    # return formatted_payload


    request_type = RequestType.create()
    # the Rest
    payload = Payload.create(request_type_id: request_type.id)
    request_type.payloads << payload
    
    # find_or_create_by()
  end

  def resolution_parse(raw_payload)
    raw_payload[:resolutionWidth] + "x" + raw_payload[:resolutionHeight]
  end

end
