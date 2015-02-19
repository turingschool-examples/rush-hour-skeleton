require "./test/test_helper"

class CreatePayloadTest < MiniTest::Test
  include Rack::Test::Methods
	attr_reader :identifier, :payload

  def setup
  	@identifier =  { identifier: "jumpstartlab",
  									 root_url: "http://jumpstartlab.com" }

  	@payload = 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
  end

  def app
    TrafficSpy::Server
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_create_payload_has_correct_parameters
  	post "/sources", identifier 
  	assert_equal 200, last_response.status

  	post "/sources/IDENTIFIER/data", payload
  	assert_equal 200, last_response.status
  	assert_equal payload.source_id, source.id
  end
  	
 end