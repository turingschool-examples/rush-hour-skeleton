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

    @payload = 'payload={"url":"http://jumpstartlab.com/blog","resolutionWidth":"1920","resolutionHeight":"1280"}'
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

  def test_data_is_populated_when_payload_is_saved
    assert_equal 0, Url.count
    assert_equal 0, Resolution.count
    post "/sources/jumpstartlab/data", @payload
    assert_equal 1, Url.count
    assert_equal 1, Resolution.count
    get "/sources/jumpstartlab"
  end

  def teardown
    DatabaseCleaner.clean
  end
end
