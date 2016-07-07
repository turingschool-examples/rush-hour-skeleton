class PayloadRequest < ActiveRecord::Base

  validates :url_id, :requested_at, :responded_in, :request_type_id, :resolution_id, :ip_id, :software_agent_id, presence: true

  belongs_to :resolutions
  belongs_to :urls
  belongs_to :request_types
  belongs_to :software_agents
  belongs_to :ips
end
