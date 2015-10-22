class TrafficSpy::Ip < ActiveRecord::Base
  belongs_to :payload
  validates :ip, uniqueness: true
end
