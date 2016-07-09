class PayloadRequest < ActiveRecord::Base
  validates :url_id, :requested_at, :responded_in, :request_type_id, :resolution_id, :ip_id, :software_agent_id, :client_id, :referral_id, presence: true

  belongs_to :resolution
  belongs_to :url
  belongs_to :request_type
  belongs_to :software_agent
  belongs_to :ip
  belongs_to :client
  belongs_to :referral

  def self.most_frequent_request_type
    verbs = PayloadRequest.all.pluck(:request_type_id)
    freq = verbs.reduce(Hash.new(0)) { |hash,value| hash[value] += 1; hash }
    id = freq.max_by { |key,value| value}
    id = id.first
    RequestType.find(id).verb
  end

  def self.url_frequency
    addresses = PayloadRequest.all.pluck(:url_id)
    freq = addresses.reduce(Hash.new(0)) { |hash,value| hash[value] += 1; hash }
    url = freq.sort_by { |key,value| value}.reverse
    url.map do |item|
      Url.find(item[0]).address
    end
  end

  def self.max_response_time
    PayloadRequest.maximum(:responded_in)
  end

  def self.max_response_time_by_url(url)
    url = Url.all.select { |m| m.address == url }
    url.first.id
    PayloadRequest.where(url_id: url.first.id).pluck(:responded_in).max
  end

  def self.min_response_time_by_url(url)
    url = Url.all.select { |m| m.address == url }
    url.first.id
    PayloadRequest.where(url_id: url.first.id).pluck(:responded_in).min
  end

end
