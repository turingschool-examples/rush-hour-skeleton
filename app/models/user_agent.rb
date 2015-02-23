module TrafficSpy
class UserAgent < ActiveRecord::Base

  has_many :payloads
  validates :browser, presence: true, uniqueness: true
  validates :browser_version, presence: true
  validates :platform, presence: true
end
end
