class RequestType < ActiveRecord::Base
  validates :request_type, presence: true

  has_many :payload_requests
end
