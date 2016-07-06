class Ip < ActiveRecord::Base
  validates :ip_address, presence: true
  has_many :payload_requests
  #when without an ip address, dont' want this to be created. 
end
