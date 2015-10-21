class TrafficSpy::Payload < ActiveRecord::Base
  belongs_to :sources
  validates :hex_digest, uniqueness: true
end
