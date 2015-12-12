module TrafficSpy
  class Event < ActiveRecord::Base
    has_many :payloads

    def self.list_of_events
      group(:event_name).order(count: :desc, event_name: :asc).count
    end
  end
end
