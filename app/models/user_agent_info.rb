class UserAgentInfo < ActiveRecord::Base
  has_many :payload_requests

  validates :browser, presence: true
  validates :version, presence: true
  validates :platform, presence: true
  validates :os, presence: true

  def self.all_browsers
    uniq.pluck("browser").sort
  end

  def self.all_oses
    uniq.pluck("os").sort
  end

end
