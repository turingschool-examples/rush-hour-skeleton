class Event < ActiveRecord::Base
  validates :event_name, presence: true
  validates :event_name, uniqueness: true

  has_many :payloads
end
