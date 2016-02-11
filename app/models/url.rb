require 'pry'

class Url < ActiveRecord::Base
  validates :address, presence: true

  has_many :payload_requests

  def find_max_response_time
    payload_requests.maximum(:responded_in)
  end

  def find_min_response_time
    payload_requests.minimum(:responded_in)
  end

  def list_response_times
    payload_requests.map { |pr| pr.responded_in }.sort.reverse
  end

  def find_average_response_time
    payload_requests.average(:responded_in).round(2)
  end

end
