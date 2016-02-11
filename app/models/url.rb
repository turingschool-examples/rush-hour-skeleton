class Url < ActiveRecord::Base
  has_many :payloads
  validates :address, presence: true

  def self.list_frequency_urls
    self.group(:address).order("count_address desc").count("address")
  end

  
end
