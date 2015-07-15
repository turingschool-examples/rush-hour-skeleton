module TrafficSpy
  class EventName < ActiveRecord::Base
    has_many :payloads
  end
end
