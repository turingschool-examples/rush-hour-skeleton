class Client < ActiveRecord::Base
  has_many :payload_requests
  has_many :user_agents, through: :payload_requests
  has_many :resolutions, through: :payload_requests
  has_many :requests,    through: :payload_requests
  has_many :ips,         through: :payload_requests
  has_many :urls,        through: :payload_requests
  has_many :referrers,   through: :payload_requests

  validates :root_url,      presence: true, uniqueness: true
  validates :identifier,    presence: true, uniqueness: true

  def valid_params(params)
    Client.exists?(params)
  end



end
