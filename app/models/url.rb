class Url < ActiveRecord::Base
  has_many :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :u_agents, through: :payload_requests

  validates :address, presence: true

  def max_response_time_given_url
    payload_requests.maximum(:responded_in)
  end

  def min_response_time_given_url
    payload_requests.minimum(:responded_in)
  end

  def all_response_time_from_most_to_least_given_url
    payload_requests.pluck(:responded_in).reverse  #TODO - find something other than reverse here
  end

  def average_response_time_given_url
    payload_requests.average(:responded_in).to_f
  end

  def list_all_verbs_given_url
    request_types.pluck(:verb)
  end

  def list_top_three_referrers_given_url
    referrers.group(:address).order(count: :desc).count.keys.take(3)
  end

  def list_top_three_u_agents_given_url
    u_agents.group(:browser, :platform).order(count: :desc).count.keys.take(3)
  end
end
