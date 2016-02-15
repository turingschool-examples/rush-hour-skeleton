class Resolution < ActiveRecord::Base
  has_many :payloads

  validates :width, presence: true
  validates :height, presence: true

  def self.resolution_breakdown
    resolutions = group("resolutions.width", "resolutions.height").order(count: :desc).count.keys
    resolutions.map {|width, height| "#{width} x #{height}"}
  end
end
