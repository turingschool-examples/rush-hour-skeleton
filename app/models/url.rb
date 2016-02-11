class Url < ActiveRecord::Base
  has_many :payloads
  validates :route, presence: true, uniqueness: true

  def self.most_frequent_urls
    self.all.sort_by do |url|
      -url.payloads.count
    end.map(&:route)
  end

  def max_response_time
    payloads.maximum(:responded_in)
  end

  def min_response_time
    payloads.minimum(:responded_in)
  end

  def ranked_response_times
    payloads.order(responded_in: :desc).pluck(:responded_in)
  end

  def average_response_time
    payloads.average(:responded_in)
  end

  def associated_verbs
    request_payloads = payloads.select(:request_type_id).distinct
    request_payloads.map do |rp|
      RequestType.find_by(id: rp.request_type_id).verb
    end
  end

  def most_popular_referrer(num)
    refer_payloads = payloads.group(:referred_id).count.sort_by do |key, value|
      value
    end
    refer_payloads.map do |key, value|
      Referred.find_by(id: key).name
    end.reverse[0..num]
  end

  def most_popular_user_agents(num)
    user_agent_payloads = payloads.group(:user_agent_id).count.sort_by do |key, value|
      value
    end
    user_agent_payloads.map do |key, value|
      user_agent = UserAgent.find_by(id: key)
      [user_agent.os, user_agent.browser]
    end.reverse[0..num]
  end

end
