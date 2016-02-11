class UserAgent < ActiveRecord::Base
  has_many :payload_requests

  validates :browser, presence: true
  validates :os, presence: true

  def self.browser_breakdown
    group(:browser).pluck(:browser)
  end
end
