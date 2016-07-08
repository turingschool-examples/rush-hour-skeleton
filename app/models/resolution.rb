class Resolution < ActiveRecord::Base
  validates :width, :height, presence: true

  has_many :payload_requests

  def self.all_resolutions_used
    widths = Resolution.all.pluck(:width)
    heights = Resolution.all.pluck(:height)

    x = widths.zip(heights)
    # # require 'pry'; binding.pry
    # puts "#{width} x #{height}"
  end

end
