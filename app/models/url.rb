class Url < ActiveRecord::Base
  has_many :payload_requests
  has_many :referrals, through: :payload_requests

  validates :root_url, presence: true
  validates :path,     presence: true

  def self.most_to_least_requested
    joins(:payload_requests).group(:root_url, :path).order("count_all desc").count
  end

  def full_path
    [self.root_url, self.path].join('')
  end

  def max_response_time
    payload_requests.maximum(:response_time)
  end

  def min_response_time
    payload_requests.minimum(:response_time)
  end

  def average_response_time
    payload_requests.average(:response_time).to_i
  end

  def all_response_times
    payload_requests.order(response_time: :desc).pluck(:response_time)
  end

  def find_verbs
    payload_requests.joins(:request_type).pluck(:verb)
  end

  def top_referrers
    payload_requests.joins(:referral).group(:root_url, :path).order("count_all desc").limit(3).count
  end

  def top_user_agents
    payload_requests.joins(:user_agent).group(:browser, :os).order("count_all desc").limit(3).count
  end
end
