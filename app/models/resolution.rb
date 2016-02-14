class Resolution < ActiveRecord::Base
  validates :width, presence: true
  validates :height, presence: true

  has_many :payload_requests

  def self.screen_resolutions
    pluck(:width, :height).uniq
  end
end
