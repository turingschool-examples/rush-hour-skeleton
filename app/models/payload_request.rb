class PayloadRequest < ActiveRecord::Base
  belongs_to :url
  belongs_to :request_type
  belongs_to :resolution
  belongs_to :user_agent
  belongs_to :referrer
  belongs_to :event_name
  belongs_to :ip

  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :parameters, presence: true
  end
