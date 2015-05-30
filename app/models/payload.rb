class Payload < ActiveRecord::Base
  validates :requested_at, uniqueness: true, presence: true
  validates :url, presence: true
  validates :responded_at, presence: true
  validates :referred_by, presence: true
  validates :requested_type, presence: true
  validates :event_name, presence: true
  validates :user_agent, presence: true
  validates :resolution_width, presence: true
  validates :resolution_height, presence: true

  belongs_to :source
end
