module TrafficSpy
  class Client < ActiveRecord::Base
    has_many :payloads

    validates :identifier, presence: true, uniqueness: true
    validates :root_url, presence: true

    def ordered_most_to_least_sites
      payloads.order('tracked_site_id').map { |load| load.tracked_site.url }.uniq
    end

    def user_agent_information
      payloads.map { |load| load.agent.user_agent }
    end

    def browser_information
      user_agent_information.map { |info| UserAgent.parse(info).browser }
    end

    def operating_systems_information
      user_agent_information.map { |info| UserAgent.parse(info).os }
    end

    def resolution_information
      payloads.map { |load| load.resolution.height_width }
    end

    def ordered_most_to_least_avg_response
      payloads.map do |load|
        {url: load.tracked_site.url, avg_time: load.tracked_site.average_response_time}
      end.uniq
    end

    def ordered_most_to_least_events
      payloads.order('event_id').map { |load| load.event.event_name }.uniq
    end

    def events_by_hour(event_id)
      payloads.where(event_id: event_id).map do |load|
        Time.parse(load.requested_at).strftime("%l %p")
      end
    end

    def count_events_by_hour(event_id)
      events = events_by_hour(event_id)
      events.map do |hour|
        {time: hour, count: events.count(hour)}
      end.uniq
    end

    def count_events(event_id)
      payloads.where(event_id: event_id).count
    end
  end
end
