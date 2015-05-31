module TrafficSpy
  class Source < ActiveRecord::Base
    has_many :payloads
    validates_presence_of :identifier, :root_url
    validates :identifier, uniqueness: true

    def list_urls
      payloads.group(:url).order('count_url DESC').count(:url)
    end

    def list_response_times
      payloads.group(:url).order('average_responded_in DESC').average(:responded_in)
    end

    def browser_breakdown
      payloads.group(:browser).order('count_browser DESC').count(:browser)
    end

    def os_breakdown
      payloads.group(:platform).order('count_platform DESC').count(:platform)
    end
  end
end
