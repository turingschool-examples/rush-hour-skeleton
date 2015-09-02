require_relative "../test_helper"

class ServerTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def test_it_creates_a_source_with_valid_attributes
    params = { identifier: "jumpstartlab",
               rootUrl: "http::/jumpstartlab.com" }
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

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end


end
