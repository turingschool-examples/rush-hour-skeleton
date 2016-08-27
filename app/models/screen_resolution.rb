class ScreenResolution < ActiveRecord::Base
  has_many :payload_requests
  validates :height, presence: true
  validates :height, uniqueness: {scope: :width}
  validates :width, presence: true
  validates :width, uniqueness: {scope: :height}

  def self.display_resolutions
    ScreenResolution.pluck(:width, :height)
  end

  def self.group_by_screen_resolution_id
    PayloadRequest.group('screen_resolution_id').count
  end

  def self.all_display_resolutions
    group_by_screen_resolution_id.to_a.map do |screen_resolution_id, sr_id_freq|
      [screen_resolution_id, [["width", ScreenResolution.find_by(:id => screen_resolution_id).width],
        ["height", ScreenResolution.find_by(:id => screen_resolution_id).height], ["count", sr_id_freq]].to_h]
    end.to_h
  end
end
