class Url < ActiveRecord::Base
  validates "url", presence: true

  has_many :payload_requests

  def self.max_url_response_time
    Url.payload_requests.maximum_response_time
  end

  def self.most_to_least_requested_urls
    ids = PayloadRequest.group(:url_id).count.keys
    ids.map {|id| Url.find(id).url}
  end
end
