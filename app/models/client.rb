module TrafficSpy
  class Client < ActiveRecord::Base
    has_many :payloads

    validates :identifier, presence: true, uniqueness: true
    validates :root_url, presence: true

    def ordered_most_to_least
      payloads.order('tracked_site_id').map do |load|
        load.tracked_site.url
      end.uniq
    end

    def user_agent_information
      payloads.map { |load| load.agent.user_agent }
    end

    def browser_information
      user_agent_information.map { |info| UserAgent.parse(info).browser }
    end

    def resolution_information
      payloads.map { |load| load.resolution.height_width }
    end

    def avg_response_ordered_most_to_least
      payloads.map do |load|
        {url: load.tracked_site.url, avg_time: load.tracked_site.average_response_time}
      end.uniq 
    end

    

  end
end
