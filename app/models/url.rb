class Url < ActiveRecord::Base
  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :referrals, through: :payload_requests

  validates :web_address, presence: true
  validates :web_address, uniqueness: true

  def response_times
    payload_requests.pluck(:responded_in)
  end

  def min_response_time
    payload_requests.min_response_time
  end

  def max_response_time
    payload_requests.max_response_time
  end

  def average_response_time
    payload_requests.average_response_time
  end

  def http_verbs
    request_types.pluck(:http_verb)
  end

  def top_three_referrers
    referrals.group(:referred_by).select("count(referral_id) as total").order('total' => :desc)
  end #random 3 :(

  def user_agents
    payload_requests.group(:user_using_id).limit(3).count(:user_using_id)
  end
end
