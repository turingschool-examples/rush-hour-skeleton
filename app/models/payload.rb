class Payload < ActiveRecord::Base
  belongs_to :agent
  belongs_to :event
  belongs_to :ip
  belongs_to :referred_by
  belongs_to :request_type
  belongs_to :resolution 
  belongs_to :url
  belongs_to :user_agent

  validates :url_id, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :referred_by_id, presence: true
  validates :request_type_id, presence: true
  validates :event_id, presence: true
  validates :agent_id, presence: true
  validates :resolution_id, presence: true
  validates :ip_id, presence: true

end
