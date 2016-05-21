class Client < ActiveRecord::Base
  has_many :payload_requests
  has_many :event_names, through: :payload_requests
  has_many :ips, through: :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :resolutions, through: :payload_requests
  has_many :urls, through: :payload_requests
  has_many :user_agents, through: :payload_requests, :class_name => "PayloadUserAgent"

  has_many :requested_ats, through: :payload_requests
  has_many :responded_ins, through: :payload_requests
  has_many :parameters, through: :payload_requests

  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true, uniqueness: true

end
