class IpAddress < ActiveRecord::Base
  validates "ip_address", presence: true

  belongs_to :payload_requests
end
