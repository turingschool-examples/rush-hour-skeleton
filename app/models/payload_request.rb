class PayloadRequest < ActiveRecord::Base
  validates :url_id,           presence: true
  validates :requested_at,     presence: true
  validates :response_time_id, presence: true
  validates :referral_id,      presence: true
  validates :request_type_id,  presence: true
  validates :event_name_id,    presence: true
  validates :user_agent_id,    presence: true
  validates :resolution_id,    presence: true
  validates :ip_id,            presence: true
end
