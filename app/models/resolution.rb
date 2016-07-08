class Resolution< ActiveRecord::Base
  validates :height,     presence: true
  validates :width,      presence:true

  has_many :payload_requests

  def self.all_screen_resolutions_across_all_requests
    res = Resolution.pluck(:width, :height)
    res.map { |r| r.join(" x ") }.join(", ")
  end
  
end
