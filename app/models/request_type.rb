class RequestType < ActiveRecord::Base
  has_many :payload_requests
end
