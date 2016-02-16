class UserSystem < ActiveRecord::Base
  validates :browser_type, presence: true
  validates :operating_system, presence: true

  has_many :payload_requests

  def self.browser_breakdown
    pluck(:browser_type).uniq
  end

  def self.os_breakdown
    pluck(:operating_system).uniq
  end
end
