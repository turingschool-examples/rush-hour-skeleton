class SystemInformation < ActiveRecord::Base
  has_many :payload_requests

  validates :browser, :operating_system, presence: true
  validates :operating_system, uniqueness: {scope: :browser}
  validates :browser, uniqueness: {scope: :operating_system}

  def self.get_all_browsers
    counts = self.group(:browser).select(:browser).map do |row|
      [row.browser, row.payload_requests.count]
    end
  end

  def self.get_all_operating_systems
    SystemInformation.pluck(:operating_system)
  end
end
