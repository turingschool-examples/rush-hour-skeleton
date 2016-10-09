class Url < ActiveRecord::Base
  validates :url_address, presence: true
  validates :url_address, uniqueness: true

  has_many :payloads
  has_many :referrals, through: :payloads
  has_many :user_agent_stats, through: :payloads
  has_many :requests, through: :payloads


  def self.most_to_least_requested
    Url.joins(:payloads).group(:url_address).order("COUNT(payloads.*) DESC").pluck(:url_address)
  end

#note that these aren't ``.self` methods (class methods) because they reference a specific url, and not the class Url.
#alisher: gotcha, Erin!
# I didn't touch the methods you created, your testing looks good!
# A few things to note as well:
# - You don't have to pass url as a parameter to these methods, as longs you you call this methods on an instance of Url class
# - Some of these methods are built in Payload, so max_response_time, for example, can be changed to:
# def max_response_time
#   payloads.max_response_time
# end
# Thanks!

  def max_response_time(url)
    url.payloads.maximum("responded_in")
  end

  def min_response_time(url)
    url.payloads.minimum("responded_in")
  end

  def average_response_time(url)
    url.payloads.average("responded_in")
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
