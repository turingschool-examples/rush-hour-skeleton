class Url < ActiveRecord::Base
  has_many :payload_requests

  validates :name, presence: true

  def max_response_time
    payload_requests.maximum("responded_in")
  end

  def min_response_time
    payload_requests.minimum("responded_in")
  end

  def response_times_longest_to_shortest
    payload_requests.order("responded_in").reverse_order.pluck("responded_in")
  end

  def average_response_time
    payload_requests.average("responded_in").round
  end
end
