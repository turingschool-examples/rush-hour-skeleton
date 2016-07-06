class PayloadRequest < ActiveRecord::Base
  validates :url, :requestedAt, :respondedIn, :referredBy, :requestType,
            :userAgent, :resolutionWidth, :resolutionHeight, :ip,
            presence: true
end
