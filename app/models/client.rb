class Client < ActiveRecord::Base
  has_many :payload_requests
  has_many :urls, through: :payload_requests
  has_many :referred_bies, through: :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :u_agents, through: :payload_requests
  has_many :resolution_ids, through: :payload_requests
  has_many :ips, through: :payload_requests


  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true, uniqueness: true
end
