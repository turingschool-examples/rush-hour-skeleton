class Client < ActiveRecord::Base
  validates :identifier, presence: true
  validates :root_url, presence: true

  validates :identifier, uniqueness: true
  validates :identifier, uniqueness: {scope: :root_url}
  validates :root_url, uniqueness: {scope: :identifier}

  has_many :payloads
  has_many :requests, through: :payloads
  has_many :urls, through: :payloads
  has_many :user_agent_stats, through: :payloads
  has_many :resolutions, through: :payloads
  has_many :events, through: :payloads

  def average_response_time_for_client
    payloads.average_response_time
  end

  def max_response_time_for_client
    payloads.max_response_time
  end

  def min_response_time_for_client
    payloads.min_response_time
  end

  def most_frequent_request_type_for_client
    requests.most_frequent_request_type
  end

  def all_http_verbs_for_client
    requests.list_all_http_verbs_used
  end

  def breakdown_browsers_client
    uas = user_agent_stats.breakdown_browsers
    user_agent_array = uas.map do |key, value|
      "#{key}: #{value} instances"
    end
  end

  def breakdown_os_client
    uas = user_agent_stats.breakdown_os
    user_agent_array = uas.map do |key, value|
      "#{key}: #{value} instances"
    end
    user_agent_array
  end

  def resolutions_for_client
    res_array = resolutions.map do |resolution|
      resolution.format
    end
    res_array.uniq
  end

  def urls_for_client
    urls.most_to_least_requested
  end
end
