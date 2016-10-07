class Payload < ActiveRecord::Base

  belongs_to :request_type

  validates :url_id, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :referred_by_id, presence: true
  validates :request_type_id, presence: true
  validates :event_name_id, presence: true
  validates :user_agent_id, presence: true
  validates :resolution_width_id, presence: true
  validates :resolution_height_id, presence: true
  validates :ip_id, presence: true

end
