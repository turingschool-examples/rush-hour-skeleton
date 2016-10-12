class EventName < ActiveRecord::Base

  has_many :payloads

  validates :event_name, presence: true
end
