class Ip < ActiveRecord::Base
  has_many :payload_requests

  validates :ip_address, presence: true
end
