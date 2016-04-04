module ClientParser
	def parse_client_and_direct_to_page
		@client = Client.find_by(identifier: params['identifier'])
		@identifier = @client.identifier if @client

		if @client == nil
			erb :not_registered
		elsif @client.payload_requests.count == 0
			erb :no_data
		elsif @client
			urls = @client.most_to_least_frequent_urls
			@urls_with_requests = Hash.new([])
			urls.map do |url|
				@urls_with_requests[url] += @client.find_payload_requests_by_relative_path(url) if @client.find_payload_requests_by_relative_path(url)
			end

			@relativepaths = @urls_with_requests.keys.map { |url| URI.parse(url).path }
			erb :dashboard
		end
	end

	def parse_event_data_and_direct_to_page(identifier, eventname)
		@event_text = "Number of " + eventname + "s= "
		@identifier = identifier
		client = Client.find_by(identifier: identifier)
		if client && client.events.find_by(name: eventname)
			event_hours = client.events.find_by(name: eventname).payload_requests.pluck(:requested_at).map do |time|
				Time.parse(time).strftime("%H")
			end

			@events_by_hour = event_hours.inject(Hash.new(0)) { |hash, hour| hash[hour] += 1; hash }
			erb :events
		else
			erb :no_event
		end
	end

	def get_client_and_events(identifier)
		@client = Client.find_by(identifier: identifier)
		@event_names = @client.events.pluck(:name).uniq
	end

	def find_relative_path_payload_requests(identifier, relativepath)
		@client = Client.find_by(identifier: identifier)
		url = "http://#{identifier}.com/#{relativepath}"
		# binding.pry
		@requests = @client.find_payload_requests_by_relative_path(url)
	end
end
