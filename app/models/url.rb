class Url < ActiveRecord::Base
  validates :url_address, presence: true
  validates :url_address, uniqueness: true

  has_many :payloads
  has_many :referrals, through: :payloads
  has_many :user_agent_stats, through: :payloads
  has_many :requests, through: :payloads

  def format
    url_address.partition(".")[2].partition("/")[2..-1].join
  end

  def self.most_to_least_requested
    joins(:payloads).group(:url_address).order("COUNT(payloads.*) DESC").pluck(:url_address)
  end

  def max_response_time
    payloads.max_response_time
  end

  def min_response_time
    payloads.min_response_time
  end

  def average_response_time
    payloads.average_response_time
  end

  def longest_to_shortest_response_time
    payloads.all_response_times
  end

  def list_of_http_verbs
    requests.list_all_http_verbs_used
  end

  def three_most_popular_referrals
    count = referrals.group(:source).count(:referral_id)
    sorted_referrals = count.sort_by { |referrer, count|  count}.reverse
    sorted_referrals.first(3).map    { |referrer|  referrer.first }
  end

  def three_most_popular_user_agents
    count = user_agent_stats.group(:browser, :operating_system).count(:user_agent_stat_id)
    sorted_uas = count.sort_by { |uas, count|  count}.reverse
    sorted_uas.first(3).map    { |uas|  uas.first }
  end
end
