module TrafficSpy
  class Url < ActiveRecord::Base
    has_many :payloads


    def longest_response_time
      payloads.maximum(:responded_in)
    end

    def shortest_response_time
      payloads.minimum(:responded_in)
    end

    def average_response_time
      payloads.average(:responded_in).to_f
    end

    def request_type
      payloads.pluck(:request_type).uniq
    end

    def most_popular_referrers
      referrers = payloads.pluck(:referred_by)
      monkey = referrers.reduce(Hash.new(0)) {|h, v| h[v] += 1; h}
      monkey
    end

    def most_popular_user_agent_browsers
      monkey = payloads.group(:browser).count.map do |key, value|
        [key.name.to_sym, value]
      end.reverse.to_h
    end

  end
end
