class UrlRequest < ActiveRecord::Base
  has_many :payload_requests

  validates :url, presence: true
  validates :parameters, presence: true

  def max_response_time
    payload_requests.maximum("responded_in")
  end

  def min_response_time
    payload_requests.minimum("responded_in")
  end
end
