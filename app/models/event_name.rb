class EventName < ActiveRecord::Base
  has_many :payloads
  validates :eventName, presence: true
end
