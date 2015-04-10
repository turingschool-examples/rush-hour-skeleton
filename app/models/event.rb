module TrafficSpy
  class Event < ActiveRecord::Base
   has_many :payloads

   validates :event_name, presence: true, uniqueness: true

  end
end
