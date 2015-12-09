module TrafficSpy
  class ProcessRequestParser
    def parse_request(string)
      parsed_request = JSON.parse(string)

      user_agent_string = parsed_request["userAgent"]
      user_agent = UserAgent.parse(user_agent_string)

      url = parsed_request["url"]
      uri = URI(url)

      { :identifier => uri.host.split(".").first,
        :relative_path => uri.path,
        :requested_at => parsed_request["requestedAt"],
        :responded_in => parsed_request["respondedIn"],
        :referred_by => parsed_request["refer"],
        :browser => user_agent.browser,
        :operating_system => user_agent.platform}
    end
  end 
end 