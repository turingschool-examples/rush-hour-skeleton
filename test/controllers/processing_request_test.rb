require './test/test_helper'
require 'json'

class ProcessingRequestTest < Minitest::Test
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

  def test_payload_data_equal_json_data
    post '/sources', { identifier:  "jumpstartlab",
                       rootUrl:     "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', payload_data

    assert_equal 1, TrafficSpy::Source.count
    assert_equal 1, TrafficSpy::Payload.count
    assert_equal 200, last_response.status
    assert_equal "Created Successfully", last_response.body
  end

  def test_users_receives_400_missing_payload_error
    post '/sources', { identifier:  "jumpstartlab",
                       rootUrl:     "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', nil

    assert_equal 1, TrafficSpy::Source.count
    assert_equal 0, TrafficSpy::Payload.count
    assert_equal 400, last_response.status
    assert_equal "payload can't be blank", last_response.body
  end

  def payload_data
     {"payload" => {"url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName":"socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211" }.to_json }
  end

end
