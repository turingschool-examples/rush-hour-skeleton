class Registration < ActiveRecord::Base
  validates_uniqueness_of :identifier
  has_many :payloads

  def urls
    payloads.group(:url).count
  end

  def screen_resolutions
  payloads.group(:screen_resolution).count
  end

  def browsers
    payloads.group(:browser).count
  end
end
