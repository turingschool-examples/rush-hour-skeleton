class Client < ActiveRecord::Base

  has_many :payload_requests
  has_many :ip_addresses,    through: :payload_requests
  has_many :referrers,       through: :payload_requests
  has_many :resolutions,     through: :payload_requests
  has_many :url_requests,    through: :payload_requests
  has_many :user_agents,     through: :payload_requests
  has_many :verbs,           through: :payload_requests

  validates :identifier, presence: true, uniqueness: true
  validates :root_url,   presence: true

  def event_breakdown(event_name)
    hourly_freq = Hash.new(0)

    date_times = payload_requests.where(event_name: event_name).pluck(:requested_at)
    times = date_times.map do |date_time|
      DateTime.parse(date_time).at_beginning_of_hour.strftime("%H:%M")
    end
    times.each do |time|
      hourly_freq[time] += 1
    end
    hourly_freq.sort
  end

  def event_total(event)
    payload_requests.where(event_name: event).count(:all)
  end
end
