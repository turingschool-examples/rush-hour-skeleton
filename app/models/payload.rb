class TrafficSpy::Payload < ActiveRecord::Base
  validates :hex_digest, uniqueness: true
end
