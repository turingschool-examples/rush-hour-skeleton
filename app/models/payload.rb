class Payload < ActiveRecord::Base

  belongs_to :request_type

  validates :url, presence: true
  validates :requestedAt, presence: true
  validates :respondedIn, presence: true
  validates :referredBy, presence: true
  validates :request_type_id, presence: true
  validates :eventName, presence: true
  validates :userAgent, presence: true
  validates :resolutionWidth, presence: true
  validates :resolutionHeight, presence: true
  validates :ip, presence: true

end
