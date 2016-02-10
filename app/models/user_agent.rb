class UserAgent < ActiveRecord::Base
  validates :browser, presence: true
  validates :platform, presence: true

  has_many :payload_requests
end
