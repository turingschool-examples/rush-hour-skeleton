class UserAgent < ActiveRecord::Base
  has_many :payload_requests
  has_many :clients, through: :payload_requests

  validates :browser, presence: true
  validates :platform, presence: true

  def self.web_browser_breakdown
    breakdown = {}
    group("browser").count.map do |browser, count|
      breakdown[browser] = count
    end
    breakdown
  end

  def self.web_platform_breakdown
    breakdown = {}
    group("platform").count.map do |platform, count|
      breakdown[platform] = count
    end
    breakdown
  end

end
