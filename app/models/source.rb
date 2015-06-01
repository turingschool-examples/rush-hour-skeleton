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
    ordered_attribute_list(:url)
  end
  
  def user_agent_data
    payloads.pluck(:user_agent).map { |data| UserAgent.parse(data) }
  end
  
  def browser_info
    ordered_attribute_list(:browser)
  end
  
  def platform_info
    ordered_attribute_list(:platform)
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

  def top_attribute(url, attribute)
    url_payloads(url).group(attribute).count.sort_by { |k, v| -v }.first.first
  end

  def top_referrer(url)
    top_attribute(url, :referred_by)
  end

  def ordered_attribute_list(attribute)
    payloads.group(attribute).count.sort_by {|k, v| -v }
  end

  def screen_res
    payloads.group(:resolution_width, :resolution_height).count
  end

  def events
    ordered_attribute_list(:event_name)
  end

  def top_browser(url)
    top_attribute(url, :browser)
  end

  def top_platform(url)
    top_attribute(url, :platform)
  end

  def total_events_received(event_name)
    payloads.where(event_name: event_name).count
  end

  def event_hourly(event_name)
    payloads.where(event_name: event_name).group_by_hour_of_day(:requested_at, format: "%l %P").count
  end
end
