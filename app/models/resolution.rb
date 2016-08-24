class Resolution < ActiveRecord::Base
  has_many :payload_requests
  
  validates :height, :width, presence: true
end