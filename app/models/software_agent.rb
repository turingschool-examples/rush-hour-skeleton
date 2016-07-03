class SoftwareAgent < ActiveRecord::Base
  validates :os, presence: true
  validates :browser, presence: true

  has_many :payload_requests
  has_many :urls, through: :payload_requests

  def self.all_browsers
    self.pluck(:browser)
  end

  def self.all_os
    self.pluck(:os)
  end
end
