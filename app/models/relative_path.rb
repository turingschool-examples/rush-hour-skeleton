module TrafficSpy
  class RelativePath < ActiveRecord::Base
    has_many :payloads
    has_many :browsers, through: :payloads
    has_many :request_types, through: :payloads
    has_many :operating_systems, through: :payloads

    def max_response_time
      payloads.maximum(:responded_in)
    end

    def min_response_time
      payloads.minimum(:responded_in)
    end

    def avg_response_time
      payloads.average(:responded_in).round(2)
    end

    def top_3_referrers
      payloads.group(:referred_by).order({count: :desc, referred_by: :asc}).count.take(3)
    end

    def top_3_browsers
      browsers.group(:browser_name).order({count: :desc, browser_name: :asc}).count.take(3)
    end

    def top_3_operating_systems
      operating_systems.group(:op_system).order({count: :desc, op_system: :asc}).count.take(3)
    end

    def verbs
      request_types.group(:verb).order({count: :desc, verb: :asc}).count
    end
  end
end
