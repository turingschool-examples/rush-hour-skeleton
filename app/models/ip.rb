class Ip < ActiveRecord::Base
  validates :ip_address, presence: true, uniqueness: true
  
  has_many :payload_requests
  #when without an ip address, don't want this to be created.
end
