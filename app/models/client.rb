class Client < ActiveRecord::Base
  validates :identifier, presence: true
  validates :root_url, presence: true

  validates :identifier, uniqueness: true
  validates :identifier, uniqueness: {scope: :root_url}
  validates :root_url, uniqueness: {scope: :identifier}

  has_many :payloads
  has_many :requests, through: :payloads
  has_many :urls, through: :payloads
  has_many :user_agent_stats, through: :payloads
  has_many :resolutions, through: :payloads
end
