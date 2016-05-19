class Url < ActiveRecord::Base
  validates :url, presence: true

  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :references, through: :payload_requests

  def self.most_to_least_requested_urls
    ids = PayloadRequest.group(:url_id).count.sort_by {|k,v| v}.reverse
    f = ids.map {|id| Url.find(id[0]).url}
  end

  def max_response_time
    payload_requests.maximum(:responded_in)
  end

  def min_response_time
    payload_requests.minimum(:responded_in)
  end

  def all_response_times
    payload_requests.order('responded_in desc').pluck(:responded_in)
  end

  def average_response_time
    payload_requests.average(:responded_in)
  end

  def all_http_verbs
    self.payload_requests.includes(:request_type).pluck(:request_type)
    # ids = payload_requests.collect { |pr| pr.request_type_id}
    # ids.map {|id| RequestType.find(id).request_type }
  end

  def top_three_referrers

    referrers = self.payload_requests.group(:reference).order('count_all desc').limit(3).count
    referrers.map { |k, v| k.reference }
  end

  def top_three_user_agents

  end
end
