class Url < ActiveRecord::Base
  validates :address, presence: true

  has_many   :payload_requests
  has_many   :request_types, through: :payload_requests
  has_many   :referrals, through: :payload_requests
  has_many   :software_agents, through: :payload_requests

  def all_response_times
    payload_requests.pluck(:responded_in).sort.reverse
  end

  def average_response_time
    (all_response_times).sum / (Url.count)
  end

  def all_verbs
    request_types.pluck(:verb)
  end

  def most_popular_referrers
    freq = referrals.group(:address).count
    top_three = freq.keys[-3..-1].reverse
  end

  def most_popular_user_agents
    freq = software_agents.group(:message).count
    top_three = freq.keys[-3..-1].reverse
  end
end
