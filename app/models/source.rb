require 'byebug'
require 'useragent'

module TrafficSpy
  class Source < ActiveRecord::Base
    validates :identifier, presence: true, uniqueness: true
    validates :root_url, presence: true

    has_many :payloads
    has_many :urls, through: :payloads


    def ordered_url
      urls = Url.pluck(:url)
      most_requested = urls.group_by {|url| url}.inject({}) do |counts, (key,value)|
        counts[key] = value.size
        counts
      end.sort_by{|value| value[1]}.reverse
    end



    def url_objects
      payloads = Payload.all
      payloads.map{|payload| payload.url}.uniq
    end

    def screen_resolution_data
      screen_resolution_ids = self.payloads.pluck(:screen_resolution_id)
      screen_resolution_ids.map do |id|
        screens = ScreenResolution.find(id)
        "#{screens.resolution_height} x #{screens.resolution_width}"
      end
    end

    def avg_response_time
      self.payloads.average(:responded_in)
    end

    def max_response_time
      self.payloads.maximum(:responded_in)
    end

    def min_response_time
      self.payloads.minimum(:responded_in)
    end

    def user_agent_data
      user_agent_ids = self.payloads.pluck(:user_agent_id)
      useragent = user_agent_ids.map do |id|
        browsers = TrafficSpy::UserAgent.find(id).web_browser
        ::UserAgent.parse(browsers)
      end
    end

    def web_browser
      user_agent_data.map{|useragent| useragent.browser}
    end

    def os_data
      user_agent_data.map{|useragent| useragent.platform}
    end

  end
end
