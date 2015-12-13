require_relative '../test_helper'

class RegisterNewUserTest < TrafficTest

  def test_user_creates_with_valid_data
    first_count = TrafficSpy::User.count
    post '/sources', {rootUrl: 'http://turing.io', identifier: 'turing'}
    second_count = TrafficSpy::User.count
    response = "{\"identifier\":\"turing\"}"

    assert_equal 200, last_response.status

    assert_equal response, last_response.body
    assert_equal 1, (second_count - first_count)
    assert_equal 'http://turing.io', TrafficSpy::User.find(1).root_url #move to model test
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
