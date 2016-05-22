class Resolution < ActiveRecord::Base
  has_many :payload_requests
  has_many :clients, through: :payload_requests
  validates :width, presence: true
  validates :height, presence: true

  def self.resolutions_breakdown
    breakdown = {}
    group("height", "width").count.map do |dimensions, count|
      breakdown["#{dimensions[0]} x #{dimensions[1]}"] = count
    end
    breakdown
  end

end
