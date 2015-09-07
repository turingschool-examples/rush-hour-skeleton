require "./test/test_helper"

class CreateSourceTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def test_it_creates_a_source_with_valid_attributes
    attributes = { identifier: "jumpstart",
                   rootUrl: "http://jumpstartlab.com" }
    post "/sources", attributes

    assert_equal 1, Source.count
    assert_equal 200, last_response.status
  end

  def test_it_will_not_create_a_source_with_a_missing_root_url
    attributes = { identifier: "jumpstart"}
    post "/sources", attributes

    assert_equal 0, Source.count
    assert_equal 400, last_response.status
    assert_equal "Bad Request - root_url can't be blank.", last_response.body
  end

  def test_it_will_not_create_a_source_with_a_missing_identifier
    attributes = { rootUrl: "http://jumpstartlab.com"}
    post "/sources", attributes

    assert_equal 0, Source.count
    assert_equal 400, last_response.status
    assert_equal "Bad Request - identifier can't be blank.", last_response.body
  end

  def test_it_will_not_create_a_source_twice
    attributes = { identifier: "jumpstart",
                   rootUrl: "http://jumpstartlab.com" }
    post "/sources", attributes
    assert_equal 1, Source.count
    assert_equal 200, last_response.status

    attributes = { identifier: "jumpstart",
                   rootUrl: "http://jumpstartlab.com" }
    post "/sources", attributes
    assert_equal 1, Source.count
    assert_equal 403, last_response.status
    assert_equal "Forbidden - identifier has already been taken.", last_response.body
  end

  def teardown
    DatabaseCleaner.clean
  end
end
