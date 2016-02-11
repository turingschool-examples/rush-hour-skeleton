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
    request_type_ids = payload_requests.group(:request_type_id).count.keys

    request_type_ids.map { |id| RequestType.where(id: id).first.verb }
  end

  def top_three_referrers

  end
end
