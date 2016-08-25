class Resolution < ActiveRecord::Base
  has_many :payload_requests

  validates :height, presence: true
  validates :width, presence: true
end
