module TrafficSpy
class UserAgent < ActiveRecord::Base

  
  validates :browser, presence: true, uniqueness: true
  validates :browser_version, presence: true
  validates :platform, presence: true
end
end