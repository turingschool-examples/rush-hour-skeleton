class Payload < ActiveRecord::Base
  belongs_to :request_type
  belongs_to :screen_resolution
  belongs_to :event_name
  belongs_to :url
  belongs_to :ip
  belongs_to :user_agent
  belongs_to :referred
  validates :request_type_id, presence: true
  validates :screen_resolution_id, presence: true
  validates :event_name_id, presence: true
  validates :url_id, presence: true
  validates :ip_id, presence: true
  validates :user_agent_id:, presence: true
  validates :referred_id, presence: true
end
