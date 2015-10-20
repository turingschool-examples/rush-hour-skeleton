require './test/test_helper'

class SourceRegistrationTest < Minitest::Test
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

  def test_user_can_register
    post '/sources', { identifier:  "jumpstartlab",
                       rootUrl:     "http://jumpstartlab.com" }

    assert_equal 1, TrafficSpy::Source.count
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body
    assert_equal 200, last_response.status
  end

end
