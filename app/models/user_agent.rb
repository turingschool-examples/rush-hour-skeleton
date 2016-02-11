class UserAgent < ActiveRecord::Base
  has_many :payloads
  validates :browser, presence: true
  validates :os, presence: true

  def self.browser_breakdown
    UserAgent.pluck(:browser)
  end

  def self.os_breakdown
    UserAgent.pluck(:os)
  end

end
