class Url < ActiveRecord::Base
  has_many :payload_requests
  has_many :referrals, through: :payload_requests

  validates :root_url, presence: true
  validates :path,     presence: true

  def self.most_to_least_requested
    # look for alternative?
    self.all.sort_by { |url| url.payload_requests.count}.reverse.map {|url| url.full_path }
  end

  def full_path
    [self.root_url, self.path].join('')
  end

  def self.max_response_time(url)
    find_by(root_url: url).payload_requests.maximum("response_time")
  end

  def self.min_response_time(url)
    find_by(root_url: url).payload_requests.minimum("response_time")
  end

  def self.average_response_time(url)
    find_by(root_url: url).payload_requests.average("response_time").to_i
  end

  def self.all_response_times(url)
    find_by(root_url: url).payload_requests.order(response_time: :desc).pluck(:response_time)
  end

  def self.find_verbs_for_a_url(url)
    require "pry"
    binding.pry
    find_by(root_url: url).payload_requests.map do |request|
      request.request_type.verb
    end.uniq
  end

  def self.top_referrers(url)
    referrer_and_count = find_by(root_url: url).payload_requests.group(:referral).count
    referrer_and_count.sort_by(&:last).reverse.take(3).to_h.keys.map {|key| key.full_path}
  end

  def self.top_user_agents(url)
    usr_agent_and_count = find_by(root_url: url).payload_requests.group(:user_agent).count
    usr_agent_and_count.sort_by(&:last).reverse.take(3).to_h.keys.map {|key| "#{key.browser} #{key.os}"}
  end
end
