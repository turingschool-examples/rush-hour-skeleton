class UAgent < ActiveRecord::Base
  has_many :payload_requests

  validates :browser, presence: true
  validates :os,      presence: true
  validates :browser, uniqueness: { scope: :os }

  def browser_counts_for_all_requests
    joins(:payload_requests).group(:browser).count
  end

  def os_counts_for_all_requests
    joins(:payload_requests).group(:os).count
  end
end
