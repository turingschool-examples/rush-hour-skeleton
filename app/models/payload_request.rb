
class PayloadRequest < ActiveRecord::Base
  validates :url, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :referrer, presence: true
  validates :request, presence: true
  validates :event, presence: true
  validates :user_agent, presence: true
  validates :resolution, presence: true
  validates :ip, presence: true
end
