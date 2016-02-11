class Resolution < ActiveRecord::Base
  has_many :payload_requests

  validates :resolution_width, presence: true
  validates :resolution_height, presence: true

  # composite key
  def self.resolution_breakdown
    pluck(:resolution_width, :resolution_height)
  end
end
