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

  def test_user_receives_400_error_when_missing_identifier
    post '/sources', { rootUrl:     "http://jumpstartlab.com" }

    assert_equal 0, TrafficSpy::Source.count
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
  end

  def test_user_receives_400_error_when_missing_rootUrl
    post '/sources', { identifier:  "jumpstartlab" }

    assert_equal 0, TrafficSpy::Source.count
    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank", last_response.body
  end
end
