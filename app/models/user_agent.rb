class UserAgent < ActiveRecord::Base
  has_many :payload_requests

  validates :browser, presence: true
  validates :platform, presence: true

  def self.browser_breakdown_across_all_requests
    pluck(:browser)
  end

  def self.platform_breakdown_across_all_requests
    pluck(:platform)
  end
end
