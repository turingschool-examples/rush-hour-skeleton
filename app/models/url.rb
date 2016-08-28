class Url < ActiveRecord::Base
  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :referrals, through: :payload_requests
  has_many :system_informations, through: :payload_requests
  validates :web_address, presence: true
  validates :web_address, uniqueness: true

  def response_times
    payload_requests.pluck(:responded_in)
  end

  def min_response_time
    payload_requests.min_response_time
  end

  def max_response_time
    payload_requests.max_response_time
  end

  def average_response_time
    payload_requests.average_response_time
  end

  def response_times_from_highest_to_lowest
    response_times.sort.reverse
  end

  def http_verbs
    request_types.pluck(:http_verb).uniq
  end

  def self.most_requested_urls
    url_counts = joins(:payload_requests).group(:web_address).count
    url_ordered_counts = url_counts.sort_by {|url, count| count }.reverse
    url_ordered_counts.collect {|url, count| url }
  end

  def top_three_referrers
    referral_count = referrals.group(:referred_by).count(:referral_id)
    sorted_referrals = referral_count.sort_by do |referred_by, count|
      count
    end.reverse
    sorted_referrals.first(3).map do |referrer|
      referrer.first
    end
  end
  
  def top_user_agents
    sys_infos = system_informations.group(:browser, :operating_system).count(:system_information_id)
    sorted_sys_info = sys_infos.sort_by do |sys_info, count|
      count
    end.reverse
    sorted_sys_info.first(3).map do |system_information|
      system_information.first
    end
  end
end
