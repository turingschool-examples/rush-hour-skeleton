class Payload < ActiveRecord::Base
  validates  :url_id, presence: true
  validates  :requested_at, presence: true
  validates  :responded_in, presence: true
  validates  :referral_id, presence: true
  validates  :request_id, presence: true
  validates  :event_id, presence: true
  validates  :user_agent_stat_id, presence: true
  validates  :resolution_id, presence: true
  validates  :visitor_id, presence: true

  belongs_to :url
  belongs_to :referral
  belongs_to :request
  belongs_to :event
  belongs_to :visitor
  belongs_to :resolution
  belongs_to :user_agent_stat
end
