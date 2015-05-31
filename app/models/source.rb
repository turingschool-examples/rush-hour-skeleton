require 'uri'

class Source < ActiveRecord::Base
  validates :root_url, presence: true
  validates :identifier, uniqueness: true, presence: true

  has_many :payloads

  def grouped_urls
    payloads.group(:url)
  end

  def path(url)
    URI(url).path
  end

  def requested_urls
    grouped_urls.count.sort_by { |k, v| v }.reverse
  end
  
  def user_agent_data
    payloads.pluck(:user_agent).map { |data| UserAgent.parse(data) }
  end
  
  def browser_info
    user_agent_data.inject({}) do |browsers, agent|
      if browsers.has_key?(agent.browser)
        browsers[agent.browser] += 1
      else
        browsers[agent.browser] = 1
      end
      browsers
    end
  end
  
  def platform_info
    user_agent_data.inject({}) do |platforms, agent|
      if platforms.has_key?(agent.platform)
        platforms[agent.platform] += 1
      else
        platforms[agent.platform] = 1
      end
      platforms
    end
  end

  def average_times
    grouped_urls.average(:responded_in).sort_by { |k, v| v }.reverse
  end

  def url_payloads(url)
    payloads.where(url: url)
  end

  def longest_time(url)
    url_payloads(url).maximum(:responded_in)
  end

  def shortest_time(url)
    url_payloads(url).minimum(:responded_in)
  end

  def average_time(url)
    url_payloads(url).average(:responded_in)
  end

  def http_routes(url)
    url_payloads(url).select(:request_type).uniq
  end
end
