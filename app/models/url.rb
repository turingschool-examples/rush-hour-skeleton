class Url < ActiveRecord::Base
  validates :address,   presence:true

  has_many :payload_requests

  def self.urls_from_most_to_least_requested
    urls = Url.pluck(:address)
    frequency = urls.inject(Hash.new(0)) { |hash , value | hash[value] += 1; hash }
    urls.max_by { |value| frequency[value] }
  end
end
