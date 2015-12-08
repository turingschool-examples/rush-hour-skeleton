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

end
