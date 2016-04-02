class Client < ActiveRecord::Base
  has_many :payload_requests
  has_many :user_agents, through: :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :urls, through: :payload_requests
  has_many :resolutions, through: :payload_requests

  validates :identifier, presence: true
  validates :root_url,    presence: true

  def has_payload_requests?
    payload_requests.any?
  end

end
