class IpAddress < ActiveRecord::Base
  has_many :payloads
end
