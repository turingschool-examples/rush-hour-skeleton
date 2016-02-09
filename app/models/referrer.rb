class Referrer < ActiveRecord::Base
  has_many :payload_requests
  
  validates :referredBy, presence: true
end
