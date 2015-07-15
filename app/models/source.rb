module TrafficSpy
  class Source < ActiveRecord::Base
    validates_presence_of :identifier, :root_url

    has_many :payloads
    has_many :urls, through: :payloads

    def most_requested_urls
      sort_urls
    end

    def browser_breakdown
      sort_browsers
    end

    def os_breakdown
      sort_operating_systems
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

  end
end
