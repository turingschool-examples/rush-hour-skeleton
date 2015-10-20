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

  def test_cannot_create_a_user_without_identifier
    post '/sources', {user: {rootUrl: "http://jumpstartlab.com"
                             } }

    assert_equal 0, User.count
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
  end

  def test_it_cannot_register_without_root_url
    post '/sources', {user: {identifier: "JumpstartLab"
                             } }

    assert_equal 0, User.count
    assert_equal 400, last_response.status
    assert_equal "Rooturl can't be blank", last_response.body
  end



end
