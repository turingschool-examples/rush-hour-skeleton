class Client < ActiveRecord::Base
  has_many :payload_requests
  has_many :user_agents, through: :payload_requests
  has_many :resolutions, through: :payload_requests
  has_many :requests,    through: :payload_requests
  has_many :ips,         through: :payload_requests
  has_many :urls,        through: :payload_requests
  has_many :referrers,   through: :payload_requests

  validates :url,           presence: true
  validates :identifier,    presence: true
end
