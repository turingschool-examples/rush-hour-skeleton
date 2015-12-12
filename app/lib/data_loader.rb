module TrafficSpy
  class DataLoader
    attr_reader :relative_path_string, :requested_at, :responded_in,
                :referred_by, :request_type_string, :event_string,
                :operating_system_string, :browser_string, :resolution_string,
                :ip_address

    def initialize(data)
      @relative_path_string = data[:relative_path_string]
      @requested_at = data[:requested_at]
      @responded_in = data[:responded_in]
      @referred_by = data[:referred_by]
      @request_type_string = data[:request_type_string]
      @event_string = data[:event_string]
      @operating_system_string = data[:operating_system_string]
      @browser_string = data[:browser_string]
      @resolution_string = data[:resolution_string]
      @ip_address = data[:ip_address]
    end

    def find_ids
      {
        relative_path_id: find_relative_path.id,
        request_type_id: find_request_type.id,
        resolution_id: find_resolution.id,
        operating_system_id: find_operating_system.id,
        browser_id: find_browser.id,
        event_id: find_event.id,
        requested_at: requested_at,
        responded_in: responded_in,
        referred_by: referred_by,
        ip_address: ip_address
      }
    end

    def find_relative_path
      TrafficSpy::RelativePath.find_or_create_by(path: @relative_path_string)
    end

    def find_request_type
      TrafficSpy::RequestType.find_or_create_by(verb: @request_type_string)
    end

    def find_resolution
      TrafficSpy::Resolution.find_or_create_by(width: @resolution_string[:width],
                                               height: @resolution_string[:height])
    end

    def find_operating_system
      TrafficSpy::OperatingSystem.find_or_create_by(op_system: @operating_system_string)
    end

    def find_browser
      TrafficSpy::Browser.find_or_create_by(browser_name: @browser_string)
    end

    def find_event
      TrafficSpy::Event.find_or_create_by(event_name: @event_string)
    end
  end
end
