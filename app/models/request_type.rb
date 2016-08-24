class RequestType < ActiveRecord::Base
  has_many :payload_requests

  validates :request_type, presence: true
  validates :request_type, uniqueness: true
end
