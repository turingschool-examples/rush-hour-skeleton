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

    def list_resolution
      width = payloads.group(:resolution_width).order('count_resolution_width DESC').count(:resolution_width)
      height = payloads.group(:resolution_height).order('count_resolution_height DESC').count(:resolution_height)
      width.keys.zip(height.keys).map { |inner_array| inner_array.join("x")}.zip(width.values)
    end

    def browser_breakdown
      payloads.group(:browser).order('count_browser DESC').count(:browser)
    end

    def os_breakdown
      payloads.group(:platform).order('count_platform DESC').count(:platform)
    end

    def list_events
      payloads.group(:event_name).order('event_name DESC').count(:event_name)
    end

    def event_by_hour(event_name)
     payloads.where(event_name: event_name).map do |event|
        Time.parse(event.requested_at).strftime("%l %p")
     end
    end

    def popular_referrer
      payloads.group(:referred_by).order('count_referred_by DESC').count(:referred_by)
    end

    def most_popular_browser
      payloads.group(:browser).order('count_browser DESC').count(:browser)
    end

    def most_popular_operating_system
      payloads.group(:platform).order('count_platform DESC').count(:platform)
    end

    def count_events(event_name)
      payloads.where(event_name: event_name).count
    end
    # counts = Hash.new 0
    #
    # words.each do |word|
    #   counts[word] += 1
    # end

    def count_events_by_hour(event_name)
      events = event_by_hour(event_name)
      events.map do |hour|
        {time: hour, count: events.count(hour)}
      end.uniq
    end

  end
end
