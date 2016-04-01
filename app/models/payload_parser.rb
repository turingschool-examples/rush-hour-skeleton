module PayloadParser
	#params parser method

	# check if client is registered
	## if not, 403 Forbidden

	# check if payload is valid
	## payload is not nil
	### all fields must be valid
	## if not, 400 Forbidden

	# if it's valid, try to find it in PayloadRequests
	## if it's already there, 403 Forbidden
	## else create the new PayloadRequest

	# if all pass, 200 OK


	def params_parser(params)
		params = JSON.parse(params['payload'])
		x = {
		 'url' => params['url'],
		 'requested_at' => params['requestedAt'],
		 'responded_in' => params['respondedIn'],
		 'referrer' => params['referredBy'],
		 'request_type' => params['requestType'],
		 'event' => params['eventName'],
		 'u_agent' => params['userAgent'],
		 'resolution_width' => params['resolutionWidth'],
		 'resolution_height' => params['resolutionHeight'],
		 'ip' => params['ip']
	  }
	end

	def validate_request(identifier, params)
		params = params_parser(params)
		return [403, "Application Not Registered"] unless client_exists?(identifier)
		return [400, "Payload Not Valid"] unless payload_valid?(params)
		return [403, "Already Received Request"] if payload_exists?(params)
		[200, "Payload Request Created"]
	end

	def client_exists?(identifier)
		Client.exists?(identifier: identifier)
	end

	def payload_valid?(params)
		platform = UserAgent.parse(params['u_agent']).platform  # TODO MAKE METHODS TO DO THIS
		browser = UserAgent.parse(params['u_agent']).browser		# AND THIS

		pr = PayloadRequest.new(url: Url.find_or_create_by(address: params['url']),
                               referrer: Referrer.find_or_create_by(address: params['referrer']),
                               request_type: RequestType.find_or_create_by(verb: params['request_type']),
                               event: Event.find_or_create_by(name: params['event']),
                               u_agent: UAgent.find_or_create_by(browser: browser, platform: platform),
                               resolution: Resolution.find_or_create_by(width: params['resolution_width'], height: params['resolution_height']),
                               ip: Ip.find_or_create_by(address: params['ip']),
															 requested_at: params['requested_at'],
                               responded_in: params['responded_in']
                              )

		pr.valid?
	end

	def payload_exists?(params)
		platform = UserAgent.parse(params['u_agent']).platform
		browser = UserAgent.parse(params['u_agent']).browser
		PayloadRequest.exists?(url: Url.find_or_create_by(address: params['url']),
                               referrer: Referrer.find_or_create_by(address: params['referrer']),
                               request_type: RequestType.find_or_create_by(verb: params['request_type']),
                               event: Event.find_or_create_by(name: params['event']),
                               u_agent: UAgent.find_or_create_by(browser: browser, platform: platform),
                               resolution: Resolution.find_or_create_by(width: params['resolution_width'], height: params['resolution_height']),
                               ip: Ip.find_or_create_by(address: params['ip']),
															 requested_at: params['requested_at'],
                               responded_in: params['responded_in']
                          )
	end

	def add_to_database(params)
		params = params_parser(params)
		platform = UserAgent.parse(params['u_agent']).platform
		browser = UserAgent.parse(params['u_agent']).browser
		PayloadRequest.create(url: Url.find_or_create_by(address: params['url']),
															 referrer: Referrer.find_or_create_by(address: params['referrer']),
															 request_type: RequestType.find_or_create_by(verb: params['request_type']),
															 event: Event.find_or_create_by(name: params['event']),
															 u_agent: UAgent.find_or_create_by(browser: browser, platform: platform),
															 resolution: Resolution.find_or_create_by(width: params['resolution_width'], height: params['resolution_height']),
															 ip: Ip.find_or_create_by(address: params['ip']),
															 requested_at: params['requested_at'],
															 responded_in: params['responded_in']
													)
	end
end
