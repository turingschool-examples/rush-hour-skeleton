class Resolution < ActiveRecord::Base
  validates :height, presence: true
  validates :width, presence: true

  has_many :payloads

  def self.height_breakdown
    joins(:payloads).group(:height).count
  end

  def self.width_breakdown
    joins(:payloads).group(:width).count
  end

  def self.resolutions_across_all_payloads
    joins(:payloads).group(:height, :width).count
  end
end
