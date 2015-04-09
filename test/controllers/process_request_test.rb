require './test/test_helper'

class ProcessRequestTest < Minitest::Test
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

  def test_it_processes_a_payload
    post '/sources',{ "identifier": "jumpstartlab", "rootUrl": "http://jumpstartlab.com"}

    payload = {
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
    }

    post '/sources/jumpstartlab/data', payload
    assert_equal 200, last_response.status
  end

  def test_it_returns_error_for_duplicate_payloads

    post '/sources',{ "identifier": "jumpstartlab", "rootUrl": "http://jumpstartlab.com"}

    payload = {
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
    }

    post '/sources/jumpstartlab/data', payload
    assert_equal 200, last_response.status

    post '/sources/jumpstartlab/data', payload
    assert_equal 403, last_response.status
    assert_equal "Composite key has already been taken", last_response.body
  end

  def test_it_returns_error_for_nonexistent_url
    post '/sources',{ "identifier": "jumpstartlab", "rootUrl": "http://jumpstartlab.com"}

    payload = {
      "url": nil,
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
    }

    post '/sources/jumpstartlab/data', payload
    assert_equal 403, last_response.status
    assert_equal "Tracked site can't be blank", last_response.body

  end

  def test_it_returns_error_for_nill_payload_values
    post '/sources',{ "identifier": nil, "rootUrl": nil}

    payload = {}

    post '/sources/jumpstartlab/data', payload
    assert_equal 400, last_response.status
    assert_equal "Payload cannot be nil", last_response.body
  end

  def test_it_return_error_if_there_is_no_payload
    post '/sources',{ "identifier": nil, "rootUrl": nil}

    post '/sources/jumpstartlab/data'
    assert_equal 400, last_response.status
    assert_equal "Payload cannot be nil", last_response.body
  end

end
