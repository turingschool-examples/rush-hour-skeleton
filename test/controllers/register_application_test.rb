require_relative '../test_helper'

class RegisterApplicationTest <Minitest::Test
  include TestHelpers
  include Rack::Test::Methods

  def test_post_request_with_valid_attributes_returns_200_status
    client_setup

    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal '{"identifier":"jumpstartlab"}', last_response.body
  end

  def test_post_request_with_existing_identifier_returns_403_error
    client_setup
    assert_equal 200, last_response.status
    assert_equal 1, Client.count

    client_setup
    assert_equal 1, Client.count
    assert_equal 403, last_response.status
    assert_equal "Please choose an identifier that's not already in use.", last_response.body
  end

  def test_post_with_missing_parameter_returns_400_bad_request
    post '/sources', {"rootUrl"=>"http://example.com"}

    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Please provide both an identifier and root url parameter.", last_response.body
  end

  def test_post_with_nil_parameter_returns_400_bad_request
    post '/sources', {"identifier"=>nil,
                    "rootUrl"=>"http://example.com"}

    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Please provide both an identifier and root url parameter.", last_response.body
  end
end
