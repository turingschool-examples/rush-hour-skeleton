class Client < ActiveRecord::Base
  has_many :payload_requests
  has_many :ips, through: :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :resolutions, through: :payload_requests
  has_many :urls, through: :payload_requests
  has_many :software_agents, through: :payload_requests

  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true, uniqueness: true
  has_many :parameters, through: :payload_requests

  def error_message
    errors.full_messages.join(", ")
  end

end
