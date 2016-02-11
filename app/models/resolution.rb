class Resolution < ActiveRecord::Base
  has_many :payloads
  validates :width, presence: true
  validates :height, presence: true

  def self.width_breakdown
   self.group(:width).order("count_width desc").count("width")
 end

 def self.height_breakdown
   self.group(:height).order("count_height desc").count("height")
 end
end
