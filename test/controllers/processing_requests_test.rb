require_relative '../test_helper'

class ProcessingRequestsTests < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  # NOTE this may need some tweaks; it was not tested
  def valid_source
    JSON.parse('{
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName": "socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"
    }')
  end

  def test_invalid_identifier_errors
    post('/sources/doesnotexist/data', { payload: valid_source } )

    assert_equal 403, last_response.status
    assert_equal 'Application Not Registered', last_response.body
  end

  def test_valid_payload_structure_gets_logged
    Source.create!(identifier: 'jumpstartlab', rooturl: 'http://jumpstartlab.com')

    post('/sources/jumpstartlab/data', { payload: valid_source } )

    assert_equal 200, last_response.status
  end

  def test_already_received_payload
    Source.create!(identifier: 'jumpstartlab', rooturl: 'http://jumpstartlab.com')

    # Send it once, it should work
    post('/sources/jumpstartlab/data', { payload: valid_source } )

    assert_equal 200, last_response.status

    # Send it again, it should error
    post('/sources/jumpstartlab/data', { payload: valid_source })

    assert_equal 403, last_response.status
    assert_equal 'Already Received Request', last_response.body
  end

end
