class SystemInformation < ActiveRecord::Base
  has_many :payload_requests

  validates :browser, :operating_system, presence: true
  validates :operating_system, uniqueness: {scope: :browser}
  validates :browser, uniqueness: {scope: :operating_system}

  def self.get_all_browsers_count
    joins(:payload_requests).group(:browser).count(:browser)
  end

  def self.get_all_operating_systems_count
    joins(:payload_requests).group(:operating_system).count(:operating_system)
  end

  def self.get_three_most_popular_system_info_combos
    system_info_combos = joins(:payload_requests).group(:browser, :operating_system).count(:browser, :operating_system)
    system_info_combos.sort_by do |sys_info, count|
      count
    end.reverse[0..2]
  end
end
