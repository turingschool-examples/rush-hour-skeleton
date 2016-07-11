class Url < ActiveRecord::Base
   validates :root, presence: true
   validates :path, presence: true, uniqueness: true

   has_many :payload_requests
   has_many :request_types, through: :payload_requests
   has_many :referrals, through: :payload_requests
   has_many :requested_at, through: :payload_requests
   has_many :user_agent_devices, through: :payload_requests

  def self.find_specific_url(path)
     find_by(path: path)
  end

  def self.top_urls
    group(:path).order('count_all DESC').count
  end

  def max_response_time_for_url
    payload_requests.max_response_time
  end

  def min_response_time_for_url
    payload_requests.min_response_time
  end

  def response_time_list_for_url
    payload_requests.return_all_response_times.sort.reverse
    # made this change
  end

  def average_response_time_for_url
    payload_requests.average_response_time
  end

  def verb_list_for_url
    request_types.verb_list.uniq
  end

  def top_referrers_for_url
    referrals.group(:name).order("count(name) DESC").limit(3).pluck(:name)
  end

  def top_user_agents_for_url
    occurrences = payload_requests.group(:user_agent_device_id).order('count_all desc').limit(3).count
    occurrences.map do |user, times|
      "Browser: #{UserAgentDevice.find(user).browser}, OS: #{UserAgentDevice.find(user).os}"
    end
  end
end
