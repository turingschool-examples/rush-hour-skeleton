class EventName < ActiveRecord::Base

  has_many :payloads

  validates :event_name, presence: true

  def events_by_hour(client)
    hours = find_hours(client)
    hours.sort.reduce({}) do |result, hour|
      result[hour] = hours.count(hour)
      result
    end
  end

  def find_hours(client)
    payloads.where(client_id: client.id).map { |payload| payload.hour }
  end

end
