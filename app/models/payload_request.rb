class PayloadRequest < ActiveRecord::Base
  has_many :request_types
  has_many :target_urls
  has_many :referrer_urls
  has_many :resolutions
  has_many :user_agents
  has_many :ips

  validates :request_type_id,   presence: true
  validates :target_url_id,     presence: true
  validates :referrer_url_id,   presence: true
  validates :resolution_id,     presence: true
  validates :user_agent_id,     presence: true
  validates :ip_id,             presence: true
  validates :responded_in,      presence: true
  validates :requested_at,      presence: true
end
