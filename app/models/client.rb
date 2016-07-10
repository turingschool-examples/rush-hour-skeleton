class Client < ActiveRecord::Base
 validates :identifier, presence: true, uniqueness: true
 validates :root_url, presence: true

 has_many :payload_requests
 has_many :urls,               through: :payload_requests
 has_many :user_agent_devices, through: :payload_requests
 has_many :ips,                through: :payload_requests
 has_many :referrals,          through: :payload_requests
 has_many :request_types,      through: :payload_requests
 has_many :resolutions,        through: :payload_requests

end
