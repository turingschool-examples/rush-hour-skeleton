class Payload < ActiveRecord::Base
  belongs_to :request_type
  belongs_to :screen_resolution
  belongs_to :event_name
  belongs_to :url
  belongs_to :ip
  belongs_to :user_agent
  belongs_to :referred
end
