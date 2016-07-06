class PayloadRequest < ActiveRecord::Base
  #presumably will put in this space belongs_to :url, etc., all the class names, once we make those.

  validates :url, presence: true
  validates :requestedAt, presence: true
  validates :respondedIn, presence: true
  validates :referredBy, presence: true
  validates :requestType, presence: true
  validates :UserAgent, presence: true
  validates :resolutionWidth, presence: true
  validates :resolultionHeight, presence: true
  validates :ip, presence: true

end
