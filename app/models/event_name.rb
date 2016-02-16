class EventName < ActiveRecord::Base
  validates :event_name, presence: true, uniqueness: true
  has_many :payload_requests

  def self.event_list
    joins(:payload_requests).group(:event_name).count.keys
  end

  def self.hourly_list(client, event)
    all_hours = (0..23).to_a

    pr = PayloadRequest.where(client_id: client.id)
    event_pr = pr.where(event_name_id: event.id)
    request_hour = event_pr.pluck(:requested_at).map do |hour|
      Time.parse(hour).hour
    end
  end

  def self.event_total(client, event)
    joins(:payload_requests).where(payload_requests: {client_id: client.id}).where(event_name: event.event_name).count
  end
end
