class UserAgent < ActiveRecord::Base
  has_many :payload_requests

  validates :browser, presence: true
  validates :os,      presence: true

  def self.all_web_browsers
    self.distinct.pluck(:browser)
  end

  def self.all_operating_systems
    self.distinct.pluck(:os)
  end
end
