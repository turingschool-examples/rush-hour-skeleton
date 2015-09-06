class Event < ActiveRecord::Base
  has_many :payloads
  has_one :source, through: :payloads

  validates :event_name, presence: true, uniqueness: true
end
