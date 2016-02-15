class EventName < ActiveRecord::Base
  validates :event_name, presence: true, uniqueness: true
  has_many :payload_requests

end
