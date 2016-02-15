class EventName < ActiveRecord::Base
  validates :event_name, presence: true, uniqueness: true
  has_many :payload_requests

  def self.event_list
    joins(:payload_requests).group(:event_name).count.keys
  end

  def self.hourly_list
    all_hours = (1..24).to_a
    request_hour = PayloadRequest.pluck(:requested_at).map do |hour|
      Time.parse(hour).hour
    end
  end

  def self.event_total
    joins(:payload_requests).count
  end
end
