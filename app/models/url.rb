class Url < ActiveRecord::Base
  has_many :payload_requests

  validates  :web_address, presence: true
  validates :web_address, uniqueness: true

  def response_times
    payload_requests.map do |request|
      request.pluck("responded_in")
    end
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
    payload_requests.http_verbs
  end

  def referalls
    payload_requests.referrals
  end

  def user_agents

  end
end
