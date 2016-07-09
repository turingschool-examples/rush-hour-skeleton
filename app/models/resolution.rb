class Resolution < ActiveRecord::Base
  validates :height, presence: true
  validates :width, presence: true 
  validates :height, uniqueness: { scope: :width }
  has_many :payload_requests

  def self.resolution
    pluck(:height, :width).map { |height_width| height_width.join(' x ') }
  end
end
