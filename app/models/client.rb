class Client < ActiveRecord::Base
  has_many :payloads
  has_many :events, through: :payloads
  has_many :ips, through: :payloads
  has_many :refers, through: :payloads
  has_many :request_types, through: :payloads
  has_many :resolutions, through: :payloads
  has_many :urls, through: :payloads
  has_many :user_environments, through: :payloads

  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true
end
