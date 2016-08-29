class Resolution < ActiveRecord::Base
  has_many :payload_requests

  validates :height, :width, presence: true
  validates :height, uniqueness: {scope: :width}
  validates :width, uniqueness: {scope: :height}

  def self.get_all_screen_resolutions
    screen_reso_counts = joins(:payload_requests).group(:height,:width).count(:height,:width)
    screen_reso_counts.collect { |resolution, count| resolution }
  end
end
