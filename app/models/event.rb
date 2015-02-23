class Event < ActiveRecord::Base

  validates :name, presence: true

  has_many :payloads

	def requested_at_hour
		times = payloads.map {|payload| payload.requested_at }
		times.map {|date| date.hour}
	end

	def hour_by_hour_breakdown
		#hour_by_hour_breakdown.each {|k,v| p "#{k}:#{v}"}
		hours_range = (0..23)
		hours_range.each_with_object({}) do |hour, hash|
			hash[hour] = requested_at_hour.select { |x| x == hour }
			hash[hour] = hash[hour].count
		end
	end

	def most_to_least_received_events
		#hash of number of instances of each event from most to least
		  # Event.all.inject(Hash.new(0)) {|sum,event| sum[event]+=1; sum }.sort_by {|k,v| -v}.to_h
		Event.all.each_with_object({}) do |event, hash|
			hash[event.name] = Event.all.select { |event_in_db| event_in_db.name == event.name }
			hash[event.name] = hash[event.name].count
		end
	end

	def event_total
		most_to_least_received_events.values.reduce(:+)
	end
end
