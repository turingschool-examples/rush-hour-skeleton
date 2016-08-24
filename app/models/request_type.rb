class RequestType < ActiveRecord::Base
  has_many :payload_requests
  
  validates :request_type, presence: true
end