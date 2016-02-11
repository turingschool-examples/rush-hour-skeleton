class ScreenResolution < ActiveRecord::Base
  has_many :payloads
  validates :size, presence: true

  def self.screen_resolution_breakdown
    ScreenResolution.pluck(:size)
  end

end
