class Url < ActiveRecord::Base
  validates :url_address, presence: true
  validates :url_address, uniqueness: true

  has_many :payloads


  def self.most_to_least_requested
    Url.joins(:payloads).group(:url_address).order("COUNT(payloads.*) DESC").pluck(:url_address)
  end

end
