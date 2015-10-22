class TrafficSpy::Payload < ActiveRecord::Base
  belongs_to :source
  validates :hex_digest, uniqueness: true
end
