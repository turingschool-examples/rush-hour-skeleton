class UserEnvironment < ActiveRecord::Base
  has_many :payloads
  validates :browser, presence: true
  validates :os, presence: true

  def self.browser_breakdown
    self.group(:browser).order("count_browser desc").count("browser")
  end

  def self.os_breakdown
    self.group(:os).order("count_os desc").count("os")
  end
  
end
