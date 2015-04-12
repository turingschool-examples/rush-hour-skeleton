class Payload < ActiveRecord::Base
  validates :ip, uniqueness: { scope: :requested_at,
  message: "Application has already been received" }

  belongs_to :url
  belongs_to :user_agent
  belongs_to :screen_resolution
  belongs_to :source
  belongs_to :request_type
  belongs_to :event_name
  belongs_to :referred_by

end
