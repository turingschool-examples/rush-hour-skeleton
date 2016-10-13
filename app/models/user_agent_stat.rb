class UserAgentStat < ActiveRecord::Base
  validates :browser, presence: true
  validates :operating_system, presence: true

  validates :browser, uniqueness: {scope: :operating_system}
  validates :operating_system, uniqueness: {scope: :browser}

  has_many :payloads
  has_many :clients, through: :payloads

  def self.breakdown_browsers
    group(:browser).count(:browser)
  end

  def self.breakdown_os
    group(:operating_system).count(:operating_system)
  end
end
