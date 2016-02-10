class Resolution < ActiveRecord::Base
  validates :height, presence: true
  validates :width, presence: true

  has_many :payload_requests
end
