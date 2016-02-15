class EventName < ActiveRecord::Base
  validates :event_name, presence: true, uniqueness: true
  has_many :payload_requests

  def self.event_list
    joins(:payload_requests).group(:event_name).count.keys
  end

  def self.hourly_list(client, event_name)
    all_hours = (0..23).to_a
    require "pry"
    # binding.pry
    pr = PayloadRequest.where(client_id: client.id)
    event_pr = pr.where(event_name_id: event_name.id)
    request_hour = event_pr.pluck(:requested_at).map do |hour|
      Time.parse(hour).hour
    end
  end

  def self.event_total(client, event)
    joins(:payload_requests).where(payload_requests: {client_id: client.id}).where(event_name: event.event_name).count
  end
end


#all payload requests for  specific client
# pr = PayloadRequest.where(client_id: client.id)
# then find only the requested event name on those prs
# event_pr = pr.where(event_name_id: event_name.id)
# compare the times on those pr's to an array
# request_hour = event_pr.pluck(:requested_at).map do |hour|
#  Time.parse(hour).hour
# end
