require "./test/test_helper"

class CreateUserTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def test_it_creates_a_user_with_valid_attributes
    attributes = { identifier: "jumpstart",
                   rootUrl: "http://jumpstartlab.com" }
    post "/sources", attributes

    assert_equal 1, User.count
    assert_equal 200, last_response.status
  end

  def teardown
    DatabaseCleaner.clean
  end

end
