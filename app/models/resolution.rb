class Resolution < ActiveRecord::Base
  validates :width, :height, presence: true

  has_many :payload_requests

  def self.all_resolutions_used
     widths = Resolution.all.pluck(:width)
     heights = Resolution.all.pluck(:height)
     widths.zip(heights).map do |resolution|
       "(#{resolution[0]} x #{resolution[1]})"
     end
   end

end
