require './test/test_helper'

class RegisterUserTest < Minitest::Test
  def test_register_a_user_with_valid_attributes
    post '/sources', {user: {identifier: "JumpstartLab",
                             rootUrl: "http://jumpstartlab.com"
                             } }

    assert_equal 1, User.count
    assert_equal 200, last_response.status
    assert_equal "User Saved!", last_response.body
  end
end
