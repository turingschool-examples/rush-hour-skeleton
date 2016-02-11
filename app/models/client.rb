class Client < ActiveRecord::Base

  has_many :payload_requests
  has_many :ip_addresses,              through: :payload_requests


  validates :identifier, presence: true
  validates :root_url,   presence: true

end
