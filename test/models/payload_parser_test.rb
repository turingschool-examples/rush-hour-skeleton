require_relative '../test_helper'
require_relative '../../app/models/payload_parser'

class PayloadParserTest < Minitest::Test
	include Rack::Test::Methods
  include TestHelpers
	include PayloadParser

	def test_can_check_if_client_is_registered
		register_client

		assert client_exists?("jumpstartlab")
		refute client_exists?("not a client")
	end

	def test_can_check_if_payload_is_valid
		params = get_params

		assert payload_valid?(params)
	end

	def test_can_check_for_duplicate_entries_when_none_exist
		params = get_params

		refute payload_exists?(params)
	end

	def test_can_check_for_duplicate_entries_when_one_exists
		params = get_params
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

		assert payload_exists?(params)
	end

	def test_can_validate_valid_json_and_send_back_200_OK_status
		params = {"payload"=>
  						"{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
 							"captures"=>["jumpstartlab"],
 							"identifier"=>"jumpstartlab"}

		register_client
		post '/sources/jumpstartlab/data', params

		assert_equal 200, last_response.status
		assert_equal "Payload Request Created", last_response.body
	end

	def test_can_check_invalid_raw_json_and_see_that_its_an_invalid_payload
		params = {"payload"=>
  						"{\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
 							"captures"=>["jumpstartlab"],
 							"identifier"=>"jumpstartlab"}

		register_client
		post '/sources/jumpstartlab/data', params

		assert_equal 400, last_response.status
		assert_equal "Payload Not Valid", last_response.body
	end

	def test_can_check_valid_json_see_that_its_a_duplicate_request
		first_params = {"payload"=>
			"{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
			"captures"=>["jumpstartlab"],
			"identifier"=>"jumpstartlab"}
		identifier = "jumpstartlab"

		register_client

		params = params_parser(first_params, identifier)
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
                         	responded_in: params['responded_in'],
												 	client: Client.find_or_create_by(identifier: params['identifier'])
                        	)

		assert_equal 1, PayloadRequest.count

		post '/sources/jumpstartlab/data', first_params

		assert_equal 403, last_response.status
		assert_equal "Already Received Request", last_response.body
	end

	def test_valid_request_gets_added_to_database
		params = {"payload"=>
  						"{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
 							"captures"=>["jumpstartlab"],
 							"identifier"=>"jumpstartlab"}

		register_client
		post '/sources/jumpstartlab/data', params

		assert_equal "Payload Request Created", last_response.body
		assert_equal 1, PayloadRequest.count
	end
end
