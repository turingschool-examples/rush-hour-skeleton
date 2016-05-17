class PayloadRequest < ActiveRecord::Base
  has_one :user_agent
  has_one :resolution

  validates :url, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :request_type, presence: true
  validates :parameters, presence: true
  validates :event_name, presence: true
  validates :user_agent_id, presence: true
  validates :resolution_id, presence: true
  validates :ip, presence: true



end
