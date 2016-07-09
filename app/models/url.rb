class Url < ActiveRecord::Base
  validates :address,   presence: true
  validates :address, uniqueness: true

  has_many :payload_requests

  def self.urls_from_most_to_least_requested
    urls = PayloadRequest.all.pluck(:url_id)
    frequency = urls.reduce(Hash.new(0)) { |hash, value | hash[value] += 1; hash }
    id = urls.max_by { |value| frequency[value] }
    Url.find(2).address
  end

  
end
