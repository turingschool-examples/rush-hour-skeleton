class PayloadRequest < ActiveRecord::Base
  belongs_to :referrer
  belongs_to :url_request

  validates :requestedAt, presence: true
  validates :respondedIn, presence: true
  validates :eventName, presence: true
  # validates :resolution_id, presence: true
  # validates :referrer_id, presence: true
  # validates :url_request_id, presence: true
  # validates :user_data_id, presence: true
end
