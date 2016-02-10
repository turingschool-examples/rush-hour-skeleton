class Resolution < ActiveRecord::Base
  has_many :payload_requests
  
  validates :resolutionWidth, presence: true
  validates :resolutionHeight, presence: true
end
