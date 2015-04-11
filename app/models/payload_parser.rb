module TrafficSpy
  class PayloadParser

    def initialize(data, identifier)
      if data.nil?
        @data = {}
      else
        @data          = JSON.parse(data)
      end

      @address_id      = Address.find_or_create_by(ip: @data["ip"]).id
      @agent_id        = Agent.find_or_create_by(user_agent: @data["userAgent"]).id
      @client_id       = Client.find_or_create_by(identifier: identifier).id
      @event_id        = Event.find_or_create_by(event_name: @data["eventName"]).id
      @referer_id      = Referer.find_or_create_by(referred_by: @data["referredBy"]).id
      @request_id      = Request.find_or_create_by(request_type: @data["requestType"]).id
      @tracked_site_id = TrackedSite.find_or_create_by(url: @data["url"]).id
      @parameters      = @data["parameters"]
      @responded_in    = @data["respondedIn"]
      @requested_at    = @data["requestedAt"]
    end

    def parameters
      @data[:parameters]
    end

    def parse
      #NEED TO REFACTOR THIS HUGE ASS-HACKY CONDITIONAL
      composite_key = []

      if @address_id  == nil
        composite_key = nil
        resolution_id = nil
      else
        @data.each_value do |value|
          composite_key << value
        end
        composite_key = composite_key.join.to_sha1
        resolution = "#{@data["resolutionHeight"]} x #{@data["resolutionWidth"]}"
        resolution_id   = Resolution.find_or_create_by(height_width: resolution).id
      end

      payload_data = {
         parameters:      @parameters,
         responded_in:    @responded_in,
         requested_at:    @requested_at,
         address_id:      @address_id,
         agent_id:        @agent_id,
         client_id:       @client_id,
         event_id:        @event_id,
         referer_id:      @referer_id,
         request_id:      @request_id,
         resolution_id:   resolution_id,
         tracked_site_id: @tracked_site_id,
         composite_key:   composite_key
          }
    end

    #Change into instance method
    def self.parse(data, identifier)

      new(data, identifier).parse

    end

  end
end
