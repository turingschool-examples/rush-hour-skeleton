class Url < ActiveRecord::Base
  validates :address,   presence: true
  validates :address, uniqueness: true

  has_many :payload_requests

  def self.urls_from_most_to_least_requested
    joins(:payload_requests).group("urls.address").order(count: :desc).count.keys
  end
end
