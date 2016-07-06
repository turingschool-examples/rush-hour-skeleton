class Resolution < ActiveRecord::Base
  validates :height, :width, presence: true
  has_many :payload_requests
end
