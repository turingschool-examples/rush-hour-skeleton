class Url < ActiveRecord::Base
  has_many :payload_requests

  validates :address, presence:true

  def max_response_time
    payload_requests.max_response_time
  end

  def min_response_time
    payload_requests.min_response_time
  end

  def response_times_across_all_requests
    payload_requests.order('responded_in DESC').pluck(:responded_in)
  end

  def average_response_time
    payload_requests.average(:responded_in).truncate
  end

  def http_verbs_associated
    payload_requests.includes(:request).pluck(:verb).uniq
  end

  def most_popular_referrers
    count_hash = payload_requests.includes(:referrer).group(:address).order('count_id DESC')
    ordered_hash= count_hash.count('id').keys[0..2]
  end

  def most_popular_user_agents
    count_hash = payload_requests.group(:user_agent_b).order('count_id DESC')
    ordered_hash = count_hash.count('id').keys
  end

end
