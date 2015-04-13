module TrafficSpy
  class PayloadParser

    def initialize(data, identifier)
      @identifier = identifier
      if data.nil?
        @data     = {}
      else
        @data     = JSON.parse(data)
      end
    end

    def parse
      {
       parameters:      parameters,
       responded_in:    responded_in,
       requested_at:    requested_at,
       address_id:      address_id,
       agent_id:        agent_id,
       client_id:       client_id,
       event_id:        event_id,
       referer_id:      referer_id,
       request_id:      request_id,
       resolution_id:   resolution_id,
       tracked_site_id: tracked_site_id,
       composite_key:   composite_key
      }
    end

    def self.parse(data, identifier)
      new(data, identifier).parse
    end

    private

    def parameters
      @data[:parameters]
    end

    def responded_in
      @data["respondedIn"]
    end

    def requested_at
      @data["requestedAt"]
    end

    def address_id
      Address.find_or_create_by(ip: @data["ip"]).id
    end

    def agent_id
      Agent.find_or_create_by(user_agent: @data["userAgent"]).id
    end

    def client_id
      if address_id  == nil
        client_id = nil
      else
        Client.find_or_create_by(identifier: @identifier).id
      end
    end

    def event_id
      Event.find_or_create_by(event_name: @data["eventName"]).id
    end

    def referer_id
      Referer.find_or_create_by(referred_by: @data["referredBy"]).id
    end

    def request_id
      Request.find_or_create_by(request_type: @data["requestType"]).id
    end

    def tracked_site_id
      TrackedSite.find_or_create_by(url: @data["url"]).id
    end

    def resolution_id
      if address_id  == nil
        resolution_id = nil
      else
        res = "#{@data["resolutionHeight"]} x #{@data["resolutionWidth"]}"
        resolution_id   = Resolution.find_or_create_by(height_width: res).id
      end
    end

    def composite_key
      if address_id  == nil
        composite_key = nil
      else
        @data.each_value.map { |value| value }.join.to_sha1
      end
    end

  end
end
