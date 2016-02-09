class PayloadRequest < ActiveRecord::Base

  validates :url, presence: true
  validates :requestedAt, presence: true
  validates :respondedIn, presence: true
  validates :referredBy, presence: true
  validates :requestType, presence: true
  validates :parameters, presence: true
  validates :eventName, presence: true
  validates :userAgent, presence: true
  validates :resolutionWidth, presence: true
  validates :resolutionHeight, presence: true
  validates :ip, presence: true

end
