class PayloadRequest < ActiveRecord::Base
  validates :url, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :referred_by, presence: true
  validates :request_type, presence: true
  validates :user_agent, presence: true
  validates :resolution_width, presence: true
  validates :resolution_height, presence: true
  validates :ip, presence: true
end
