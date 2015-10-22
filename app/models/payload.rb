class TrafficSpy::Payload < ActiveRecord::Base
  belongs_to :source
  has_many :urls
  has_many :events
  has_many :user_agents
  has_many :ips
  validates :hex_digest, uniqueness: true
end
