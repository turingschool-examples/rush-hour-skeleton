require 'pry'

class Payload < ActiveRecord::Base
  belongs_to :agent
  belongs_to :event
  belongs_to :ip
  belongs_to :referred_by
  belongs_to :request_type
  belongs_to :resolution
  belongs_to :url
  belongs_to :user_agent
  belongs_to :client

  validates :url_id, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :referred_by_id, presence: true
  validates :request_type_id, presence: true
  validates :event_id, presence: true
  validates :agent_id, presence: true
  validates :resolution_id, presence: true
  validates :ip_id, presence: true
  validates :client_id, presence: true

  def self.average_response_time
    average(:responded_in)
  end

  def self.max_response_time
    maximum(:responded_in)
  end

  def self.min_response_time
    minimum(:responded_in)
  end

  def self.most_frequent_request_type
    id = group(:request_type_id).count.max_by{|key, value| value}.first
    RequestType.find(id).http_verb #look into order = "Sal"
  end

  def self.all_request_types
    group(:request_type_id).count.keys.map do |id|
      RequestType.find(id).http_verb
    end.sort
  end

  def self.urls_descending
    grouped_urls = group(:url_id).count.sort_by do |key, value|
      value
    end.reverse

    grouped_urls.map do |e|
      Url.find(e.first).root_url + Url.find(e.first).path
    end
  end

  def self.browser_breakdown
    grouped_browsers = self.group(:agent_id).count
    grouped_browsers.reduce({}) do |hash, (key, value)|
       hash[Agent.find(key).browser] = value
       hash
    end
  end

  def self.os_breakdown
    grouped_os = self.group(:agent_id).count
    grouped_os.reduce({}) do |hash, (key, value)|
       hash[Agent.find(key).operating_system] = value
       hash
    end
  end

  def self.resolutions_breakdown
    grouped_rez = group(:resolution_id).count
    grouped_rez.reduce({}) do  |hash, (key, value)|
      keys = {}
      keys["height"] = Resolution.find(key).height
      keys["width"] = Resolution.find(key).width
      hash[keys] = value
      hash
    end
  end
end
