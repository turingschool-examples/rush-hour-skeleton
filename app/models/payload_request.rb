class PayloadRequest < ActiveRecord::Base
  validates :url, presence :true
  validates :requestedAt, presence :true
  validates :respondedIn, presence :true
  # model as response
  validates :referredBy, presence :true
  validates :requestType, presence :true
  validates :parameters, presence :true
  # has many parameters
  validates :eventName, presence :true
  validates :userAgent, presence :true
  validates :resolutionWidth, presence :true
  validates :resolutionHeight, presence :true
  validates :ip, presence :true
end
