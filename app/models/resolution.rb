class Resolution < ActiveRecord::Base
  validates :height, presence: true
  validates :width, presence: true

  has_many :payloads

  def self.height_breakdown
    group(:height).count
  end

  def self.width_breakdown
    group(:width).count
  end

  def self.resolutions_across_all_payloads
    group(:height, :width).count
  end
end
