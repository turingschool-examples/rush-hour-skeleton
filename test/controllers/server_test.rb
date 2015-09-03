require_relative "../test_helper"

class ServerTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def test_it_creates_a_source_with_valid_attributes
    params = { identifier: "jumpstartlab",
               rootUrl: "http://jumpstartlab.com" }
    post "/sources", params
    assert_equal 1, Source.count
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body
  end

  def test_it_doesnt_create_source_with_missing_attributes
    params = { rootUrl: "http::/jumpstartlab.com" }
    post "/sources", params
    assert_equal 0, Source.count
    assert_equal 400, last_response.status
    assert_equal "Missing Parameters: Identifier can't be blank", last_response.body
  end

  def test_it_does_not_create_source_with_non_unique_attributes
    params = { identifier: "jumpstartlab",
               rootUrl: "http::/jumpstartlab.com" }
    post "/sources", params
    post "/sources", params
    assert_equal 1, Source.count
    assert_equal 403, last_response.status
    assert_equal "Non-unique Value: Identifier has already been taken", last_response.body
  end

  def test_it_creates_visit_with_valid_attributes
    skip
    seed_data = { identifier: "jumpstartlab",
               rootUrl: "http::/jumpstartlab.com" }
    post "/sources", seed_data
    params = {payload: "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"}
    post "/sources/jumpstartlab/data", params

    assert_equal 200, last_response.status
  end

  def test_it_does_not_create_visit_when_missing_payload
    skip
    seed_data = { identifier: "jumpstartlab",
               rootUrl: "http://jumpstartlab.com" }
    post "/sources", seed_data
    params = {}
    post "/sources/jumpstartlab/data", params

    assert_equal 400, last_response.status
    assert_equal "Missing Payload", last_response.body
  end

#   As a user
# When I submit a POST request to "/sources/jumpstartlab/data"
# With a request containing JSON data in a unique parameter named "payload"
# Where payload = {
#   "url":"http://jumpstartlab.com/blog",
#   "requestedAt":"2013-02-16 21:38:28 -0700",
#   "respondedIn":37,
#   "referredBy":"http://jumpstartlab.com",
#   "requestType":"GET",
#   "parameters":[],
#   "eventName": "socialLogin",
#   "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#   "resolutionWidth":"1920",
#   "resolutionHeight":"1280",
#   "ip":"63.29.38.211"
# }
# Then I should recieve a response of "200 OK"

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end


end
