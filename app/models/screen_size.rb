class ScreenSize < ActiveRecord::Base
  has_many :payload_requests

  validates :resolution_width, presence: true
  validates :resolution_height, presence: true

  def self.all_screen_sizes
    resolutions = uniq.pluck("resolution_height", "resolution_width")
    resolutions.map do |resolution|
      resolution.join(" x ")
    end
  end
end
