class PayloadRequest < ActiveRecord::Base
  validates :url, :requestedAt, :respondedIn, :referredBy, :requestType,
            :userAgent, :resolutionWidth, :resolutionHeight, :ip,
            presence: true
  belongs_to :url, :referral, :request_type, :user_agent, :resolution, :ip
end
