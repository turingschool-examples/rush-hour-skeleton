class Browser < ActiveRecord::Base
  has_many :payloads
  has_one :source, through: :payloads

  validates :browser, presence: true, uniqueness: true
  validates :operating_system, presence: true, uniqueness: true

  def list_browsers(source)
    source.browsers.group(:browser).count
  end

  def list_operating_systems(source)
    source.browsers.group(:operating_system).count
  end
end
