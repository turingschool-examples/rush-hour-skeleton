module TrafficSpy
  class EventData
    def self.prep_payload(payload)
      payload = payload.map do |payload|
        payload.requested_at
      end
    end

    def self.hour_counts(payload)
      times = prep_payload(payload)
      time_count = times.group_by { |utc| DateTime.parse(utc.to_s).hour }
      @counts = time_count.map { |find| find.last.count }
      hour = time_count.map { |find| find.first }
      time_counts = hour.zip(@counts).sort
    end

    def self.total_count(payload)
      @counts.reduce(:+)
    end
  end
end
