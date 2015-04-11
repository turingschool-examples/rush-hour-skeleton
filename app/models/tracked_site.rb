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
      payloads_response_time.order('responded_in desc').first
    end

    def shortest_response_time
      payloads_response_time.order('responded_in desc').last
    end

  end
end
