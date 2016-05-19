class Resolution < ActiveRecord::Base
  validates "resolution_width", presence: true
  validates "resolution_height", presence: true

  has_many :payload_requests
end
