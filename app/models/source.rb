module TrafficSpy
  class Source < ActiveRecord::Base
    validates_presence_of :identifier, :root_url

    has_many :payloads
    has_many :urls, through: :payloads
    has_many :browsers, through: :payloads
    has_many :operating_systems, through: :payloads
    has_many :screen_resolutions, through: :payloads

    def most_requested_urls
      sort_urls
    end

    def browser_breakdown
      sort_browsers
    end

    def os_breakdown
      sort_operating_systems
    end

    def screen_resolution_breakdown
      sort_screen_resolutions
    end

    private

    def urls
      payloads.map do |payload|
        payload.url.address
      end
    end

    def url_counts
      urls.reduce(Hash.new(0)) {|h, v| h[v] += 1; h}
    end

    def sort_urls
      urls.uniq.sort_by {|v| url_counts[v]}.reverse
    end

    def browsers
      payloads.map do |payload|
        payload.browser.name
      end
    end

    def browser_counts
      browsers.reduce(Hash.new(0)) {|h, v| h[v] += 1; h}
    end

    def sort_browsers
      browsers.uniq.sort_by {|v| browser_counts[v]}.reverse
    end

    def operating_systems
      payloads.map do |payload|
        payload.operating_system.name
      end
    end

    def operating_system_counts
      operating_systems.reduce(Hash.new(0)) {|h, v| h[v] += 1; h}
    end

    def sort_operating_systems
      operating_systems.uniq.sort_by {|v| operating_system_counts[v]}.reverse
    end

    def screen_resolutions
      payloads.map do |payload|
        w = payload.screen_resolution.width
        h = payload.screen_resolution.height
        [w, h]
      end
    end

    def screen_resolution_counts
      screen_resolutions.reduce(Hash.new(0)) {|h, v| h[v] += 1; h}
    end

    def sort_screen_resolutions
      screen_resolutions.uniq.sort_by {|v| screen_resolution_counts[v]}.reverse
    end

  end
end
