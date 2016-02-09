class PayloadRequest < ActiveRecord::Base

  validates :requestedAt, presence: true
  validates :respondedIn, presence: true
  validates :resolution_id, presence: true
  validates :referrer_id, presence: true
  validates :url_request_id, presence: true
  validates :user_data_id, presence: true
end
