class EventName < ActiveRecord::Base
  validates :event_name, presence: true
  has_many :payload_requests
end

def self.sort_events_most_received_to_least
  en = group(:event_name_id).count
  return "No events have been defined" if en == {}
  sorted_arr = en.sort_by { |k,v| v }.reverse
  sorted_arr.map { |elem| where(id: elem[0]).first.event_name}
end
