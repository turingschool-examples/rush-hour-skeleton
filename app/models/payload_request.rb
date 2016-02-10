
class PayloadRequest < ActiveRecord::Base
  validates :url_id, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :referrer_id, presence: true
  validates :request_id, presence: true
  validates :event_id, presence: true
  validates :user_agent_id, presence: true
  validates :resolution_id, presence: true
  validates :ip_id, presence: true

  belongs_to :referrer
  belongs_to :request
  belongs_to :event
  belongs_to :user_agent
  belongs_to :resolution 
end
