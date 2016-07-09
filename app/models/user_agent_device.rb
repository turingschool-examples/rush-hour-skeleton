class UserAgentDevice < ActiveRecord::Base
  validates :browser, presence: true
  validates :os, presence: true
  validates :browser, uniqueness: { scope: :os }

  has_many :payload_requests

  def self.browser_breakdown
    group(:browser).count
  end

  def self.os_breakdown
    group(:os).count
  end

end
