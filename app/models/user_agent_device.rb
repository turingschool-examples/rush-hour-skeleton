class UserAgentDevice < ActiveRecord::Base
  validates :browser, :os, presence: true
  has_many :payload_requests

  def self.browser_breakdown
    group(:browser)
  end

  def self.os_breakdown
    group(:os)
  end
end
