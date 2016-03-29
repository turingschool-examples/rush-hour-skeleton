class PayloadRequest < ActiveRecord::Base

  belongs_to :url
  belongs_to :requested
  belongs_to :responded_in
  belongs_to :referrer
  belongs_to :request_verb
  belongs_to :parameter
  belongs_to :event
  belongs_to :user_agent
  belongs_to :resolution_height
  belongs_to :resolution_width
  belongs_to :ip

  validates :requested_at, presence: true
  validates :responded_in, presence: true
end
