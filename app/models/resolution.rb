class Resolution < ActiveRecord::Base
  has_many :payload_requests

  validates :width, presence: true
  validates :height, presence: true
end
