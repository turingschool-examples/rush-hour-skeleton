class Client < ActiveRecord::Base
  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true, uniqueness: true

  has_many :payload_requests
  has_many :ips,               through: :payload_requests
  has_many :referrer_urls,     through: :payload_requests
  has_many :resolutions,       through: :payload_requests
  has_many :urls,              through: :payload_requests
  has_many :user_systemes,     through: :payload_requests
  has_many :request_types,     through: :payload_requests
  has_many :event_names,       through: :payload_requests

end
