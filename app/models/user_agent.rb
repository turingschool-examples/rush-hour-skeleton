module TrafficSpy
class UserAgent < ActiveRecord::Base

  belongs_to :payload
  validates :browser, presence: true, uniqueness: true
  validates :browser_version, presence: true
  validates :platform, presence: true
end
end
