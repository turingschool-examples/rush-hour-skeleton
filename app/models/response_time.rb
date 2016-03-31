class ResponseTime < ActiveRecord::Base
  has_many :payload_requests

  validates :time, presence: true

  def self.avg
    # join payloads?
    self.average("time")
  end

  def self.max
    self.maximum("time")
  end

  def self.min
    self.minimum("time")
  end
end
