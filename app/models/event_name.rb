class EventName < ActiveRecord::Base
  has_many :payloads
  validates :name, presence: true
end
