class UserAgentB < ActiveRecord::Base
  has_many :payload_requests

  validates :browser, presence: true
  validates :platform, presence: true

  def self.web_browser_breakdown
    self.pluck(:browser).uniq
  end

  def self.os_breakdown
    self.pluck(:platform).uniq
  end
end
