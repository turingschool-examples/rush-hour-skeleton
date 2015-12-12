module TrafficSpy
  class PayloadParser
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def p_pams
      JSON.parse(params["payload"])
    end

    def ua
      UserAgent.parse(p_pams["userAgent"])
    end

    def resolution
      Resolution.find_or_create_by(dimension: "#{p_pams["resolutionWidth"]} x #{p_pams["resolutionHeight"]}")
    end

    def browser
      ua.browser
    end

    def os
      ua.platform
    end

    def user
      User.find_by(identifier: params["id"])
    end

    def url
      p_pams["url"]
    end

    def parameters
      p_pams["parameters"]
    end

    def requested_at
      p_pams["requestedAt"]
    end

    def request_type
      p_pams["requestType"]
    end

    def responded_in
      p_pams["respondedIn"]
    end

    def referred_by
      p_pams["referredBy"]
    end

    def event_name
      p_pams["eventName"]
    end

    def ip
      p_pams["ip"]
    end

    def payload_sha
      Digest::SHA1.hexdigest(p_pams.to_s)
    end

    def payload_response
      if params["payload"].nil?
      status, body = [400, "No payload received in the request"]
      else
        if user.nil?
          status, body = [403, "#{params["id"]} is not registered"]
        elsif TrafficSpy::Payload.find_by(payload_sha: payload_sha)
          status, body = [403, "This specific payload already exists in the database..."]
        else
          TrafficSpy::Payload.create(user_id: user.id, resolution_id: resolution.id, url: p_pams["url"], requested_at: p_pams["requestedAt"], responded_in: p_pams["respondedIn"], referred_by: p_pams["referredBy"], request_type: p_pams["requestType"], parameters: p_pams["parameters"], event_name: p_pams["eventName"], user_agent: browser, ip: p_pams["ip"],  payload_sha: payload_sha, os: os)
        end
      end
    end

  end
end
