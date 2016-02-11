class UserAgent < ActiveRecord::Base
  has_many :payload_requests

  validates :browser, presence: true
  validates :os, presence: true

  def self.os_breakdown
    group(:os).pluck(:os)
  end
end
