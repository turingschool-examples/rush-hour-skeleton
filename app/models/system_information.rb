class SystemInformation < ActiveRecord::Base
  has_many :payload_requests

  validates :browser, :operating_system, presence: true
  validates :operating_system, uniqueness: {scope: :browser}
  validates :browser, uniqueness: {scope: :operating_system}


  def self.get_all_browsers_count
    joins(:payload_requests).group(:browser).count(:browser)
  end
end
