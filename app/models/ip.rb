class Ip < ActiveRecord::Base
  validates :ip_address, presence: true

  has_many :payload_requests
end
