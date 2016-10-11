class Url < ActiveRecord::Base

  has_many :payloads
  has_many :request_types, through: :payloads
  has_many :referred_bies, through: :payloads
  has_many :agents, through: :payloads

  validates :url, presence: true

  def all_response_times_by_url
    payloads.reduce([]) do |result, payload|
      result << payload.responded_in
    end.sort.reverse
  end

  def max_response_time_by_url
    all_response_times_by_url.max
  end

  def min_response_time_by_url
    all_response_times_by_url.min
  end

  def average_response_time_by_url
    all_response_times_by_url.reduce(:+)/all_response_times_by_url.length
  end

  def http_verbs_by_url
    request_types.reduce([]) do |result, request_row|
      result << request_row.request_type
      result
    end.uniq
  end

  def self.most_to_least_requested(payloads)
    order = payloads.order('url_id DESC')
    order.reduce([]) do |result, object|
      result << object.url.url
      result
    end.uniq
  end

  def three_most_popular_referrers
    referred_bies.map { |obj| [obj.referred_by, payloads.pluck(:referred_by_id).count(obj.id)] }.uniq.sort_by { |k| k[1] }.reverse.first(3)
  end

  def three_most_popular_user_agents
    agents.map { |obj| [obj.agent, payloads.pluck(:agent_id).count(obj.id)] }.uniq.sort_by { |k| k[1] }.reverse.first(3).map do |ua|
      [UserAgent.os(ua.to_s), UserAgent.browser_name(ua.to_s).to_s]
    end.uniq
  end

end
