module TrafficSpy
  class Event < ActiveRecord::Base
    has_many :payloads

    def self.list_of_events
      group(:event_name).order(count: :desc, event_name: :asc).count
    end

    def total_requests
      payloads.count
    end

    def requests_by_hour(hour)
      payloads.pluck(:requested_at).map { |t| t.hour }.count(hour)
    end
  end
end
