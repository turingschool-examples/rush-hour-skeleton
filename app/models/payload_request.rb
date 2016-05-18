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
  validates :url_id, presence: true
  validates :referrer_id, presence: true
  validates :request_type_id, presence: true
  validates :event_name_id, presence: true
  validates :user_agent_id, presence: true
  validates :resolution_id, presence: true
  validates :ip_id, presence: true
  end
