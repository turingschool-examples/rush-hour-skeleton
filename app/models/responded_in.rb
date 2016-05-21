class RespondedIn < ActiveRecord::Base
  has_many :payload_requests
  has_many :urls, through: :payload_requests

  validates :time, presence: true, uniqueness: true

  def self.average_response_time
    average("time")
  end

  def self.max_response_time
    maximum("time")
  end

  def self.min_response_time
    minimum("time")
  end
end
