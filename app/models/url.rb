class Url < ActiveRecord::Base
  validates "url", presence: true

  has_many :payload_requests

  def self.most_to_least_requested_urls
    ids = PayloadRequest.group(:url_id).count.keys
    ids.map {|id| Url.find(id).url}
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
    payload_requests.collect { |pr| pr.request_type_name}
  end

  def top_three_referrers
    a = payload_requests.collect {|pr| pr.reference}.reverse.uniq.take(3)
  end
end
