class Visit < ActiveRecord::Base
  belongs_to :url
  belongs_to :source
  validates :sha_identifier, presence: true, uniqueness: true
  validates :responded_in, presence: true
  validates :requested_at, presence: true
  validates :referred_by, presence: true
  validates :request_type, presence: true
  validates :event_name, presence: true
  validates :user_agent, presence: true
  validates :resolution_width, presence: true
  validates :resolution_height, presence: true
  validates :source_id, presence: true
  validates :url_id, presence: true
end
