class PayloadRequest < ActiveRecord::Base
  belongs_to :referrer
  belongs_to :url_request
  belongs_to :user_agent
  belongs_to :resolution
  belongs_to :ip_address

  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :event_name, presence: true
  # validates :resolution_id, presence: true
  # validates :referrer_id, presence: true
  # validates :url_request_id, presence: true
  # validates :user_data_id, presence: true
end
