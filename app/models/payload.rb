class Payload < ActiveRecord::Base
  belongs_to :user
  belongs_to :ip
  belongs_to :url
  belongs_to :event
  belongs_to :resolution
  belongs_to :user_agent
  belongs_to :request_type
  belongs_to :requested_at
  belongs_to :reffered_by
  belongs_to :responded_in
end
