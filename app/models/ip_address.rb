class IpAddress < ActiveRecord::Base
  has_many :payload_requests

  validates :ip, presence: true, uniqueness: true
end
