class Url < ActiveRecord::Base
   validates :root, presence: true
   validates :path, presence: true

   has_many :payload_requests
   has_many :request_types, through: :payload_requests
   has_many :referrals, through: :payload_requests
   has_many :requested_at, through: :payload_requests
   has_many :user_agent_devices, through: :payload_requests

  def self.find_specific_url(path)
     find_by(path: path)
  end

  def max_response_time_for_url
    payload_requests.max_response_time
  end

  def min_response_time_for_url
    payload_requests.min_response_time
  end

  def response_time_list_for_url
    payload_requests.return_all_response_times
  end

  def average_response_time_for_url
    payload_requests.average_response_time
  end

  def verb_list_for_url
    request_types.verb_list
  end

  def top_referrers_for_url
    # rough start need to map by the values to assert counts
    l = referrals.return_all_referrals.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    l.keys
  end

  def top_user_agents_for_url
    # rough start need to map by the values to assert counts
    l = user_agent_devices.user_agent_pair.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    l.keys
  end
end
