require './test/test_helper'

class UserRegistrationTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_user_can_register
    post '/sources', { user: { identifier:  "jumpstartlab",
                               rootURL:     "http://jumpstartlab.com" } }
    assert_equal "{'identifier':'jumpstartlab'}", last_response.body
    assert_equal 200, last_response.status
  end

end
