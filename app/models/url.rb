class Url < ActiveRecord::Base
  has_many :payloads
  validates :address, presence: true

  def self.list_frequency_urls
    binding.pry
    self.order(:address).count
  end
end
