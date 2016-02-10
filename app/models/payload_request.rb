class PayloadRequest < ActiveRecord::Base
  belongs_to :referrer
  belongs_to :url_request
  belongs_to :user_agent
  belongs_to :resolution

  validates :requestedAt, presence: true
  validates :respondedIn, presence: true
  validates :eventName, presence: true
  # validates :resolution_id, presence: true
  # validates :referrer_id, presence: true
  # validates :url_request_id, presence: true
  # validates :user_data_id, presence: true
end
