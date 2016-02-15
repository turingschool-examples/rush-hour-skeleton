class UserAgent < ActiveRecord::Base
  has_many :payload_requests

  validates :browser, presence: true
  validates :os, presence: true
  validates_uniqueness_of :browser, scope: [:os]

  def self.os_breakdown
    group(:os).pluck(:os)
  end

  def self.browser_breakdown
    group(:browser).pluck(:browser)
  end
end
