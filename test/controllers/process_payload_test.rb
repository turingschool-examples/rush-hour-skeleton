require "./test/test_helper"

class ProcessPayloadTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
    @payload = "payload={\"url\":\"http://jumpstartlab.com/blog\",
      \"requestedAt\":\"2013-02-16 21:38:28 -0700\",
      \"respondedIn\":37,
      \"referredBy\":\"http://jumpstartlab.com\",
      \"requestType\":\"GET\",
      \"parameters\":[],
      \"eventName\":\"socialLogin\",
      \"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",
      \"resolutionWidth\":\"1920\",
      \"resolutionHeight\":\"1280\",
      \"ip\":\"63.29.38.211\"
      }"
  end

  def test_it_checks_a_payloads_uniqueness
    attributes = { identifier: "jumpstartlab",
                   rootUrl: "http://jumpstartlab.com" }
    post "/sources", attributes

    assert_equal 1, User.count
    assert_equal 200, last_response.status

    post "/sources/jumpstartlab/data", @payload

    assert_equal 1, Sha.count
    assert_equal 200, last_response.status

    post "/sources/jumpstartlab/data", @payload

    assert_equal 1, Sha.count
    assert_equal 403, last_response.status
    assert_equal 'Forbidden - Must be unique payload', last_response.body

    post "/sources/cakeisawesome/data", @payload

    assert_equal 403, last_response.status
    assert_equal 'Forbidden - Must have registered identifier', last_response.body

    post "/sources/jumpstartlab/data"

    assert_equal 1, Sha.count
    assert_equal 400, last_response.status
    assert_equal 'Bad Request - Needs a payload', last_response.body
  end

  def teardown
    DatabaseCleaner.clean
  end
end