class PayloadRequest < ActiveRecord::Base
  validates :requested_at, :responded_in, :resolution_id, :user_agent_id, :referral_id, :ip_id, :request_type_id, :url_id, presence: true
end
