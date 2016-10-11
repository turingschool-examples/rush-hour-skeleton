class Resolution < ActiveRecord::Base

  has_many :payloads

  validates :resolution_width, presence: true
  validates :resolution_height, presence: true

  def self.resolution_breakdown(payloads)
    Resolution.all.reduce({}) do |result, resolution_row|
      count = payloads.pluck(:resolution_id).count(resolution_row.id)
      width = resolution_row.resolution_width
      height = resolution_row.resolution_height
      result["#{width} x #{height}"] = count
      result
    end
  end
end
