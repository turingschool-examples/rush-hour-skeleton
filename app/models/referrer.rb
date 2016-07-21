class Referrer < ActiveRecord::Base
  validates :address,   presence: true

  validates :address,  uniqueness: true

  has_many :payload_requests
  has_many :clients, through: :payload_requests

  def self.top_three_referrers_for_url(url)
    ids = PayloadRequest.pluck(:referred_by_id)
    final = []
    result = {}
    ids.each { |element| result[element] = ids.count(element) }
    id_array = result.sort_by { |key, value| value }.to_h.keys[0..2]
    find_referers(id_array)
  end

  def self.find_referers(ids)
    payloads=[]
    ids.each do |id|
      address = Referrer.find(id).address
      payloads.push(address)
    end
    payloads
  end

end
