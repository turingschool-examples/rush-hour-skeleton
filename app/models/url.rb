class Url < ActiveRecord::Base
  has_many :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :user_agents, through: :payload_requests

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
    referrers.group(:address).count.keys.reverse.take(3)
  end

  #def jon's homework goes here - last iter 2 question. 
end
