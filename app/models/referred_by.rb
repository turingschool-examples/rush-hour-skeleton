class ReferredBy < ActiveRecord::Base
  has_many :payload_requests
  
  validates :url, presence: true, uniqueness: true

end
