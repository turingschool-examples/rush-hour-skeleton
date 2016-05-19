class EventName < ActiveRecord::Base
  has_many :payload_requests
  has_many :clients, through: :payload_requests

  validates :name, presence: true

  def self.events_breakdown
    breakdown = {}
    group("name").count.map do |name, count|
      breakdown[name] = count
    end
    breakdown
  end
end
