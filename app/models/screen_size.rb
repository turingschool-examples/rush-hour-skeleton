class ScreenSize < ActiveRecord::Base
  has_many :payload_requests

  validates :resolution_width, presence: true
  validates :resolution_height, presence: true

  # def self.all_screen_sizes
  #       uniq.pluck("").sort
  # end
end
