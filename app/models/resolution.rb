class Resolution < ActiveRecord::Base
  has_many :payload_requests

  validates :width, presence: true
  validates :height, presence: true

  # def self.resolutions
  #   all.map do |object|
  #     object.width * object.height
  #   end
  # end
end
