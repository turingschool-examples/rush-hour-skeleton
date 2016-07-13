class Ip < ActiveRecord::Base
  validates :ip_address, presence: true, uniqueness: true

  has_many :payload_requests
end
