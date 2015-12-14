module TrafficSpy
  class Payload < ActiveRecord::Base
    belongs_to :user
    belongs_to :resolution

    def self.url_popularity
      group(:url).count.sort.to_h
    end

    def self.browser_popularity
      group(:user_agent).count.sort.to_h
    end

    def self.os_popularity
      group(:os).count.sort.to_h
    end

    def self.resolution_popularity
      group(:resolution_id).count.sort.to_h
    end

    def self.avg_response_time
      group(:url).average(:responded_in)
    end

    def self.max_response_time
      maximum(:responded_in)
    end

    def self.min_response_time
      minimum(:responded_in)
    end

    def self.average_response_time_per_url
      average(:responded_in).round(3)
    end

    def self.http_verbs
      pluck(:request_type).uniq
    end

    def self.referrers
      group(:referred_by).count.sort_by{ |k, v| v}.reverse[0..2]
    end

    def self.browsers
      group(:user_agent).count.sort_by{ |k, v| v}.reverse[0..2]
    end

    def self.known_url?(path)
      exists?(url: path)
    end

    def self.event_frequency
      group(:event_name).count.sort.to_h
    end

    def self.events_by_hour(event)
      data = group(:event_name).group('EXTRACT(HOUR FROM requested_at)').count
      data.select {|k, v| k.first == event }
    end

    def self.total_events(event)
      events_by_hour(event).values.reduce(:+)
    end

  end
end
