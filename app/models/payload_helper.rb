require 'json'
require 'useragent'
module TrafficSpy
  class PayloadHelper
    attr_accessor :status, :body

    def self.call(params, identifier)
      if params[:payload] == nil
          @status = 400
          @body = "Payload can't be blank"
      else
        payload_hash = JSON.parse(params[:payload])
        if source_exists?(identifier)
          payload = add_payload(identifier, payload_hash)
          if duplicate_source?(payload)
            @status = 403
            @body = "Already Received Request"
          elsif payload.save
            @status = 200
            @body = "OK"
          else
            @status = 400
            @body = "Payload can't be blank"
          end
        else
          @status = 403
          @body = "Application not registered"  
        end
      end
    end

    def self.source_exists?(identifier)
      Source.exists?(identifier: identifier)
    end

    def self.duplicate_source?(payload)
      Payload.exists?(requested_at: payload.requested_at) &&
      Payload.exists?(source_id: payload.source_id)
    end

    def self.add_payload(identifier, payload_hash)
      user_agent = ::UserAgent.parse(payload_hash["user_agent"])
      Payload.new(
            url: Url.find_or_create_by(name: payload_hash["url"]),
            requested_at: payload_hash["requestedAt"],
            responded_in: payload_hash["respondedIn"],
            referred_by: payload_hash["referredBy"],
            request_type: payload_hash["requestType"],
            parameters: payload_hash["parameters"],
            event_name: payload_hash["eventName"],
            user_agent: TrafficSpy::UserAgent.find_or_create_by(browser: user_agent.browser, version: user_agent.version, platform: user_agent.platform),
            resolution_width: payload_hash["resolutionWidth"],
            resolution_height: payload_hash["resolutionHeight"],
            ip: payload_hash["ip"],
            source: Source.find_by(identifier: identifier)
            )
    end

    def self.status
      @status
    end

    def self.body
      @body
    end
  end
end