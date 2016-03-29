class ResponseTime < ActiveRecord::Base
  validates :time, presence: true

  def self.avg
    self.average("time")
  end

  def self.max
    self.maximum("time")
  end

  def self.min
    self.minimum("time")
  end
end
