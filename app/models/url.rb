class Url < ActiveRecord::Base
  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  validates :url, presence: true

  def maximum_response_time
    payload_requests.maximum("responded_in")
    # url.payload_requests.maximum("responded_in")
  end

  def minimum_response_time
    payload_requests.minimum("responded_in")
  end

  def response_times_by_order
    payload_requests.order(responded_in: :desc).pluck("responded_in")
  end

  def average_response_time
    payload_requests.average("responded_in")
  end

# may decide to create explicit url.request_types method (which is redundant)


end
