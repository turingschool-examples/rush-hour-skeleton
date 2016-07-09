class UserAgentDevice < ActiveRecord::Base
  validates :browser, presence: true
  validates :os, presence: true
  validates :browser, uniqueness: { scope: :os }

  has_many :payload_requests

  def self.browser_breakdown
    group(:browser)
  end

  def self.os_breakdown
    group(:os)
  end
  
end
