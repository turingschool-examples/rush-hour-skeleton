class RequestType < ActiveRecord::Base
  validates "request_type", presence: true

  belongs_to :payload_requests
end
