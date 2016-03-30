class Url < ActiveRecord::Base
  has_many :payload_requests

  validates :address, presence: true

  def self.most_to_least_requested
    group(:address).count.keys.reverse
  end
end
