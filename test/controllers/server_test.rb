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
    assert_equal "Successfully created", last_response.body
  end

  def test_it_doesnt_create_source_with_missing_attributes
    skip
    params = { rootUrl: "http::/jumpstartlab.com" }
    post "/sources", params
    assert_equal 0, Source.count
    assert_equal 400, last_response.status
    assert_equal "Description can't be blank", last_response.body
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end


end
