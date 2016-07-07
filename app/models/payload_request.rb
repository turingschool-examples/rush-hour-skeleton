class PayloadRequest < ActiveRecord::Base

  validates :url_id, :requested_at, :responded_in, :request_type_id, :resolution_width, :resolution_height, :ip, :user_agent_id, presence: true

  belongs_to :resolutions
  belongs_to :urls
  belongs_to :request_types
  belongs_to :user_agents
  belongs_to :ips
end
