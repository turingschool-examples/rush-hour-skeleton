class Resolution < ActiveRecord::Base
  validates "resolution_width", presence: true
  validates "resolution_height", presence: true

  belongs_to :payload_requests
end
