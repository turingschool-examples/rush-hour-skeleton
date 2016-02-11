class Url < ActiveRecord::Base
  has_many :payload_requests
  validates :address, presence: true

  def max_response_time
    payload_requests.maximum(:responded_in)
  end

  def min_response_time
    payload_requests.minimum(:responded_in)
  end

  def all_response_times
    payload_requests.group(:responded_in).count.keys.sort.reverse
  end

  def average_response_time
    payload_requests.average(:responded_in)
  end

  def all_http_verbs
    # find all verb for a specific url id
    # This returns all verbs for all urls:
    RequestType.pluck(:verb)
  end
end
