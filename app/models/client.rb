class Client < ActiveRecord::Base

  has_many :payloads
  has_many :request_types, through: :payloads
  has_many :urls, through: :payloads
  has_many :agents, through: :payloads
  has_many :resolutions, through: :payloads

  validates :identifier, presence: true
  validates :root_url, presence: true
end
