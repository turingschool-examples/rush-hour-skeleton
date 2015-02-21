class Event < ActiveRecord::Base

  validates :name, presence: true

  has_many :payloads

	def event_payloads
		#all payloads with event_id == id
			payloads
	end
	
	def requested_at_hour
		dates = event_payloads.pluck(:requested_at)
		dates.map { |date| DateTime.parse(date).hour}	
	end

	def hour_by_hour_breakdown
		#a hash of each hour coupled with 
		#how many instances of that event occurred in that hour
		#hour_by_hour_breakdown.each {|k,v| p "#{k}:#{v}"}

		(0..23).each_with_object({}) do |hour, hash|
			hash[hour] = requested_at_hours.select { |x| x == hour }
			hash[hour] = hash[hour].count
		end

	end

	def most_to_least_received_events	
		#hash of number of instances of each event from most to least
		Event.all.inject(Hash.new(0)) { |sum, event| sum[event] += 1; sum }
			.sort_by {|event, total| -total }.to_h
	end 

	# Event.all.each_with_object({}) do |event, hash|
	# 	hash[event.name] = Event.all.select { |event_in_db| event_in_db.name == event.name }
	# 	hash[event.name] = hash[event.name].count
	# end
# end

	def event_total
		hour_by_hour_breakdown.values.reduce(:+)
	end
	
end


