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
      payload.map do |load|
        load.agent.user_agent
      end
    end

    def browser_information
      user_agent_information.map do |info|
        UserAgent.parse(info).browser
      end
    end

  end
end
