require_relative '../test_helper'
require 'json'

class RegisterNewUserTest < TrafficTest

  def test_user_creates_with_valid_data
    first_count = User.count
    post '/sources', {rootUrl: 'http://turing.io', identifier: 'turing'}
    second_count = User.count
    response = "{\"identifier\":\"turing\"}"

    assert_equal 200, last_response.status

    assert_equal response, last_response.body
    assert_equal 1, (second_count - first_count)
    # binding.pry
    assert_equal 'http://turing.io', User.find(1).root_url
  end

  def test_user_receives_400_bad_request_and_error_message_when_missing_root_url
    post '/sources', {identifier: 'turing'}

    assert_equal 400, last_response.status
    assert_equal "Missing all required details.", last_response.body
  end

  def test_user_receives_400_bad_request_and_error_message_when_missing_identifier
    post '/sources', {rootUrl: 'http://turing.io'}

    assert_equal 400, last_response.status
    assert_equal "Missing all required details.", last_response.body
  end

  def test_user_receives_403_and_error_message_when_registering_duplicate_identifier
    post '/sources', {rootUrl: 'http://turing.io', identifier: 'turing'}
    post '/sources', {rootUrl: 'http://turing.io', identifier: 'turing'}

    assert_equal 403, last_response.status
    assert_equal "Identifier already exists.", last_response.body
  end

end

