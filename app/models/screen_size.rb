class ScreenSize < ActiveRecord::Base
  has_many :payload_requests

  validates :resolution_width, presence: true
  validates :resolution_height, presence: true
end
