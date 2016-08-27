class UAgent < ActiveRecord::Base
  has_many :payload_requests

  validates :browser, presence: true
  validates :os,      presence: true
  validates :browser, uniqueness: { scope: :os }

  def self.browser_counts_for_all
    joins(:payload_requests).group(:browser).count
  end

  def self.os_counts_for_all
    joins(:payload_requests).group(:os).count
  end
end
