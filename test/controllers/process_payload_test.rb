require "./test/test_helper"

class ProcessPayloadTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start

    attributes = { identifier: "jumpstartlab",
                   rootUrl: "http://jumpstartlab.com" }
    post "/sources", attributes

    assert_equal 1, Source.count
    assert_equal 200, last_response.status

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

  def test_it_checks_a_payloads_is_processed_correctly
    post "/sources/jumpstartlab/data", @payload

    assert_equal 1, Payload.count
    assert_equal 200, last_response.status
  end

  def test_it_checks_a_payloads_uniqueness
    post "/sources/jumpstartlab/data", @payload

    assert_equal 1, Payload.count
    assert_equal 200, last_response.status

    post "/sources/jumpstartlab/data", @payload

    assert_equal 1, Payload.count
    assert_equal 403, last_response.status
    assert_equal 'Forbidden - Must be unique payload', last_response.body
  end

  def test_payload_must_be_from_a_registered_source
    post "/sources/cakeisawesome/data", @payload

    assert_equal 403, last_response.status
    assert_equal 'Forbidden - Must have registered identifier', last_response.body
  end

  def test_process_must_contain_a_payload
    post "/sources/jumpstartlab/data"

    assert_equal 0, Payload.count
    assert_equal 400, last_response.status
    assert_equal 'Bad Request - Needs a payload', last_response.body
  end

  def test_url_data_is_populated_when_payload_is_saved
    assert_equal 0, Url.count

    post "/sources/jumpstartlab/data", @payload

    # get "/sources/jumpstartlab"

    # assert_equal 1, Url.count
  end

  def teardown
    DatabaseCleaner.clean
  end
end
