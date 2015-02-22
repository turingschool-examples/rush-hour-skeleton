require "./test/test_helper"
require 'json'

class CreatesPayloadTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end


  def test_creates_payload_with_attributes
    Source.create(identifier: "jumpstartlab", rootUrl: "http://example.com")

    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    assert_equal 1, Payload.count
    assert_equal 200, last_response.status
    assert_equal "successful", last_response.body

  end

  def test_cannot_create_payload_without_being_registered
    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    assert_equal 0, Payload.count
    assert_equal 403, last_response.status
    assert_equal "source is not registered", last_response.body
  end

  def test_payload_populates_all_tables
    Source.create(identifier: "jumpstartlab", rootUrl: "http://example.com")
    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    assert_equal "http://jumpstartlab.com/blog", Url.find(1).address
    assert_equal "2013-02-16 21:38:28 -0700", Payload.find(1).requested_at
    assert_equal 37, Payload.find(1).responded_in
    assert_equal "http://jumpstartlab.com", ReferredBy.find(1).name
    assert_equal "GET", RequestType.find(1).verb
    assert_equal "socialLogin", Event.find(1).name
    assert_equal "Chrome", Browser.find(1).name
    assert_equal "Macintosh", Os.find(1).name
    assert_equal ["1920", "1280"], [Resolution.find(1).width, Resolution.find(1).height]
    assert_equal "63.29.38.211", IpAddress.find(1).address
  end

  def test_does_not_create_duplicate_payload
    Source.create(identifier: "jumpstartlab", rootUrl: "http://example.com")
    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    assert_equal 1, Payload.count
    assert_equal 200, last_response.status
    assert_equal "successful", last_response.body

    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    assert_equal 1, Payload.count
    assert_equal 403, last_response.status
    assert_equal "payload already exists", last_response.body
  end

  def test_does_not_create_payload_with_incorect_parameters
    Source.create(identifier: "jumpstartlab", rootUrl: "http://example.com")
    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280"}'

    assert_equal 0, Payload.count
    assert_equal 400, last_response.status
    assert_equal "incorrect amount of payload parameters", last_response.body
  end

  def teardown
    DatabaseCleaner.clean
  end
end
