class PayloadRequest < ActiveRecord::Base

  validates :url, :requested_at, :responded_in, :referred_by, :request_type, :resolution_width, :resolution_height, :ip, :user_agent_id, presence: true

end
