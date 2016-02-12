require 'json'
require_relative '../test_helper'

class RegisterApplication <Minitest::Test
  include Rack::Test::Methods

  def app
    RushHour::Server
  end

  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def test_post_request_with_valid_attributes_returns_200_status
    skip
    post '/sources', {
        identifier: "jumpstartlab",
        root_url: "http://jumpstartlab.com"
      }
    assert_equal 1, Payload.count
    assert_equal 200, last_response.status
    assert_equal '{"identifier":"jumpstartlab"}', last_response.body
  end

  def test_post_request_with_existing_identifier_returns_403_error
  end

  def test_post_with_missing_parameter_returns_400_bad_request

  end

end
