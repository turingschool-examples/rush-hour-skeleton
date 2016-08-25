class ScreenResolution < ActiveRecord::Base
  has_many :payload_requests
  validates :height, presence: true
  validates :height, uniqueness: {scope: :width}
  validates :width, presence: true
  validates :width, uniqueness: {scope: :height}

  def self.display_resolutions
    ScreenResolution.pluck(:width, :height)
  end

  def self.screen_resolution_id_count
    PayloadRequest.group('screen_resolution_id').count
  end

  def self.display_resolution_count
      
  end
end
