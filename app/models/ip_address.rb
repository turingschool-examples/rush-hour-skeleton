class IpAddress < ActiveRecord::Base
  has_many :payload_requests
  validates :address, presence: true
  validates :address, uniqueness: true
end
