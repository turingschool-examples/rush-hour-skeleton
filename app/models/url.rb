class Url < ActiveRecord::Base
  has_many :payload_requests

  validates :address, presence: true

  def self.most_to_least_requested
    # require 'pry'; binding.pry
    order(address: :desc).pluck(:address).uniq
  end
end
