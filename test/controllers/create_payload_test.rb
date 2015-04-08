require './test/test_helper'
require 'byebug'

class CreatePayloadTest < Minitest::Test
  include Rack::Test::Methods

  def app 
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_creates_data_when_passed_payload
    post '/sources/jumpstartlab/data',
         'payload={
         "url":"http://jumpstartlab.com/blog",
         "requestedAt":"2013-02-16 21:38:28 -0700",
         "respondedIn":37,
         "referredBy":"http://jumpstartlab.com",
         "requestType":"GET",
         "parameters":[],
         "eventName": "socialLogin",
         "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
         "resolutionWidth":"1920",
         "resolutionHeight":"1280",
         "ip":"63.29.38.211"}'
    payload = Payload.first

    assert_equal "http://jumpstartlab.com/blog", payload.url
    assert_equal 1, payload.source_id
    assert_equal "socialLogin", payload.event_name
  end

  def test_creates_data_when_there_are_two_sources
    post '/sources', 'identifier=turing&rootUrl=http://turing.io'

    post '/sources/turing/data',
         'payload={
         "url":"http://turing.io/blog",
         "requestedAt":"2013-02-16 21:38:28 -0700",
         "respondedIn":37,
         "referredBy":"http://jumpstartlab.com",
         "requestType":"GET",
         "parameters":[],
         "eventName": "socialLogin",
         "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
         "resolutionWidth":"1920",
         "resolutionHeight":"1280",
         "ip":"63.29.38.211"}'
    payload = Payload.first

    assert_equal "http://turing.io/blog", payload.url
    assert_equal 2, payload.source_id 
    assert_equal "socialLogin", payload.event_name
  end

  def test_it_returns_200_when_OK
    post '/sources/jumpstartlab/data',
         'payload={
         "url":"http://jumpstartlab.com/blog",
         "requestedAt":"2013-02-16 21:38:28 -0700",
         "respondedIn":37,
         "referredBy":"http://jumpstartlab.com",
         "requestType":"GET",
         "parameters":[],
         "eventName": "socialLogin",
         "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
         "resolutionWidth":"1920",
         "resolutionHeight":"1280",
         "ip":"63.29.38.211"}'
    assert_equal 200, last_response.status
    assert_equal "OK", last_response.body
  end

  def test_it_returns_400_when_missing_payload
    payload_count = Payload.count
    post '/sources/jumpstartlab/data', 'payload={}'

    assert_equal payload_count, Payload.count
    assert_equal 400, last_response.status
    assert_equal "Payload can't be blank", last_response.body
  end

  def test_it_returns_403_when_missing_identifier
    post '/sources/jumpstartlab/data', 'payload={
         "url":"http://jumpstartlab.com/blog",
         "requestedAt":"2013-02-16 21:38:28 -0700",
         "respondedIn":37,
         "referredBy":"http://jumpstartlab.com",
         "requestType":"GET",
         "parameters":[],
         "eventName": "socialLogin",
         "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
         "resolutionWidth":"1920",
         "resolutionHeight":"1280",
         "ip":"63.29.38.211"}'

    post '/sources/jumpstartlab/data', 'payload={
         "url":"http://jumpstartlab.com/blog",
         "requestedAt":"2013-02-16 21:38:28 -0700",
         "respondedIn":37,
         "referredBy":"http://jumpstartlab.com",
         "requestType":"GET",
         "parameters":[],
         "eventName": "socialLogin",
         "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
         "resolutionWidth":"1920",
         "resolutionHeight":"1280",
         "ip":"63.29.38.211"}'

 
    assert_equal 403, last_response.status
    assert_equal "Already Received Request", last_response.body
  end

  def test_it_returns_403_when_application_not_registered
    skip
    post '/sources/turing/data', 'payload={
         "url":"http://turing.io/blog",
         "requestedAt":"2013-02-16 21:38:28 -0700",
         "respondedIn":37,
         "referredBy":"http://turing.io",
         "requestType":"GET",
         "parameters":[],
         "eventName": "socialLogin",
         "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
         "resolutionWidth":"1920",
         "resolutionHeight":"1280",
         "ip":"63.29.38.211"}'
    assert_equal 403, last_response.status
    assert_equal "Application not registered", last_response.body

  end
end