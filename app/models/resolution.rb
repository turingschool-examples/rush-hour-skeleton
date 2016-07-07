class Resolution < ActiveRecord::Base
  has_many :payload_requests

  validates :width, presence: true
  validates :height, presence: true

  def self.resolutions
    resolutions = Hash.new(0)
    all.each do |object|
      resolutions[object.width * object.height] += 1
    end
    resolutions
  end
end
