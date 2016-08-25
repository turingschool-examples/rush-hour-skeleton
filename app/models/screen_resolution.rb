class ScreenResolution < ActiveRecord::Base
  has_many :payload_requests
  validates :height, presence: true
  validates :height, uniqueness: true
  validates :width, presence: true
  validates :width, uniqueness: true

  def self.display_resolutions
    ScreenResolution.pluck(:width, :height)
  end
end
