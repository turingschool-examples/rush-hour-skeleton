class Url < ActiveRecord::Base
  validates :address, presence: true
  validates :address, uniqueness: true

  has_many :payload_requests
  has_many :clients, through: :payload_requests
  has_many :software_agents, through: :payload_requests

  def self.urls_from_most_to_least_requested
    joins(:payload_requests).group("urls.address").order(count: :desc).count.keys
  end

  def popular_agents
    software_agents.group("os","browser").order(count: :desc).count.take(3)
  end

  def max_response_time_for_url
    payload_requests.maximum(:responded_in)
  end

  def min_response_time_for_url
    payload_requests.minimum(:responded_in)
  end

  def average_response_time_for_url
    payload_requests.average(:responded_in)
  end

  def list_of_response_times_across_requests_for_urls
    payload_requests.pluck(:responded_in).sort.reverse
  end

  def http_verbs_used_for_urls
    verb_ids = payload_requests.pluck(:request_type_id)
    verb_ids.map { |verb_id| RequestType.find(verb_id).verb }
  end

  def three_most_popular_referrers
    ref_ids = payload_requests.group(:referred_by_id).order(count: :desc).count.keys.take(3)
    ref_ids.map { |ref_id| Referrer.find(ref_id).address }
  end

  def three_most_popular_software_agents
    agent_ids = payload_requests.group(:software_agent_id).order(count: :desc).count.keys.take(3)
    agent_ids.map do |agent_id|
       agent = SoftwareAgent.find(agent_id)
       "#{agent.os} #{agent.browser}"
     end
  end
end
