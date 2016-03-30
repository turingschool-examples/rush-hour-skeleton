class PayloadRequest < ActiveRecord::Base

  belongs_to :url
  belongs_to :referrer
  belongs_to :request_type
  belongs_to :parameter
  belongs_to :event
  belongs_to :user_agent
  belongs_to :resolution
  belongs_to :ip
  belongs_to :client

  validates :requested_at, presence: true
  validates :responded_in, presence: true

  def self.average_response_time
    average(:responded_in)
  end

  def self.max_response_time
    maximum(:responded_in)
  end

  def self.min_response_time
    minimum(:responded_in)
  end

  def self.max_response_time_by_url(url_address)
    ids = Url.where(address: url_address).pluck(:id)
    times = ids.map {|id| where(id: id).pluck(:responded_in)}
    times.flatten.max
  end

  def self.min_response_time_by_url(url_address)
    ids = Url.where(address: url_address).pluck(:id)
    times = ids.map {|id| where(id: id).pluck(:responded_in)}
    times.flatten.min
  end

  def self.all_response_time_by_url(url_address)
    ids = Url.where(address: url_address).pluck(:id)
    times = ids.map {|id| where(id: id).pluck(:responded_in)}
    times.flatten.reverse
  end

  def self.average_response_time_by_url(url_address)
    ids = Url.where(address: url_address).pluck(:id)
    times = ids.map {|id| where(id: id).pluck(:responded_in)}
    times.flatten.inject(:+)/times.count
  end

  def self.list_http_verbs_by_url(url_address)
    ids = Url.where(address: url_address).pluck(:id)
    ids.map {|id| RequestType.where(id: id).pluck(:verb)}.flatten
  end

  def self.top_three_referrers_by_url(url_address)
    ids = Url.where(address: url_address).pluck(:id)
    addresses = ids.map {|id| Referrer.where(id: id).pluck(:address)}.flatten
    addresses.inject(Hash.new(0)) {|hash, item| hash[item] += 1; hash}.keys.take(3)
  end

  def self.top_three_browsers_by_url(url_address)
    ids = Url.where(address: url_address).pluck(:id)
    browsers = ids.map {|id| UserAgent.where(id: id).pluck(:browser)}.flatten
    browsers.inject(Hash.new(0)) {|hash, item| hash[item] += 1; hash}.sort_by(&:last).reverse.take(3).to_h.keys

  end

  def self.top_three_platforms_by_url(url_address)
    ids = Url.where(address: url_address).pluck(:id)
    platforms = ids.map {|id| UserAgent.where(id: id).pluck(:platform)}.flatten
    platforms.inject(Hash.new(0)) {|hash, item| hash[item] += 1; hash}.sort_by(&:last).reverse.take(3).to_h.keys
  end

  def self.top_three_browsers_and_platforms_by_url(url_address)
    top_three_platforms_by_url(url_address).zip(top_three_browsers_by_url(url_address))

  end
end
