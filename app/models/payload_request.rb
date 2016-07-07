class PayloadRequest < ActiveRecord::Base
  validates :url, :requested_at, :responded_in, :referred_by, :request_type, :user_agent, :resolution_id, :ip, presence: true

  belongs_to :resolutions
  belongs_to :urls
  belongs_to :request_types
  belongs_to :user_agents
  belongs_to :ips
end
