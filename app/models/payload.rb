module TrafficSpy
  class Payload < ActiveRecord::Base
    belongs_to :application
    validates_uniqueness_of :application_id, scope: [:relative_path, :requested_at,
                                                     :responded_in, :referred_by,
                                                     :request_type, :event,
                                                     :operating_system, :browser,
                                                     :resolution, :ip_address]

    def self.group_count_and_order(field)
      group(field).order(count: :desc).count
      # proposed bug fix:
      # group(field).count.sort.sort_by { |key, count| [ -count, key ] }
    end

    def self.group_average_and_order_response_times
      group(:relative_path).average(:responded_in).sort_by{ |_, v| -v }
    end

    def self.matching(relative_path)
      where(relative_path: relative_path)
    end

    def self.max_response_time
      maximum(:responded_in)
    end

    def self.min_response_time
      minimum(:responded_in)
    end

    def self.avg_response_time
      average(:responded_in).round(2)
    end

    def self.get_top_3(field)
      group_count_and_order(field).take(3)
    end

    def self.requests_by_hour(hour)
      pluck(:requested_at).map { |t| t.hour }.count(hour)
    end
  end
end
