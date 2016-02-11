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
end
