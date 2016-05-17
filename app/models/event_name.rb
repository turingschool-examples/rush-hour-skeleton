class EventName < ActiveRecord::Base
  validates "event_name", presence: true

  belongs_to :payload_requests
end
