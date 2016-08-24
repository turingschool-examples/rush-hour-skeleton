class UserAgent < ActiveRecord::Base
  has_many :payload_requests
  
  validates :browser, :operating_system, presence: true
end