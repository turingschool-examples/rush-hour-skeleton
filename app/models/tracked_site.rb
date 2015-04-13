module TrafficSpy
  class TrackedSite < ActiveRecord::Base
    has_many :payloads

    validates :url, presence: true

    def average_response_time
      payloads.average(:responded_in).to_f.round
    end

    def payloads_response_time
      payloads.select(:responded_in)
    end

    def longest_response_time
      payloads.maximum(:responded_in).to_f.round
    end

    def shortest_response_time
      payloads.minimum(:responded_in).to_f.round
    end

    def http_verbs
      payloads.map { |load| load.request.request_type }.uniq
    end

    def referers
      payloads.map { |load| load.referer.referred_by }.uniq
    end

    def ordered_most_popular_user_agents
      payloads.group("agent_id").order("count_agent_id desc").count("agent_id")
    end

    def ordered_most_to_least_agents
      payloads.order('agent_id').map do |load|
        load.agent.user_agent
      end.uniq
    end

  end
end
