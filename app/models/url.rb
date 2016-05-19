class Url < ActiveRecord::Base
  validates "url", presence: true

  has_many :payload_requests

  def self.most_to_least_requested_urls
    ids = PayloadRequest.group(:url_id).count.keys
    ids.map {|id| Url.find(id).url}
  end

  def max_url_response_time
    payload_requests.maximum(:responded_in)
  end

  def min_url_response_time
    payload_requests.minimum(:responded_in)
  end

  def all_response_times
    payload_requests.pluck(:responded_in)
  end

  def average_response_time
    payload_requests.average(:responded_in)
  end
end
