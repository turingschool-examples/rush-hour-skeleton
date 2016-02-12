class UserSystem < ActiveRecord::Base
  validates :browser_type, presence: true
  
  has_many :payload_requests
end
