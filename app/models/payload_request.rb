class PayloadRequest < ActiveRecord::Base
  validates :url, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :referred_by, presence: true
  validates :request_type, presence: true
  validates :parameters_id, presence: true
  validates :event_name, presence: true
  validates :user_agent_id, presence: true
  validates :resolution_id, presence: true
  validates :ip_id, presence: true
end
