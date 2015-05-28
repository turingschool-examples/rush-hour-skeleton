module TrafficSpy
  class Address < ActiveRecord::Base
   has_many :payloads
   validates :ip, presence: true, uniqueness: true
  end
end
