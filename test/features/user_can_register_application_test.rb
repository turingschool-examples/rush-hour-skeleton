require_relative '../test_helper'

class UserCanRegisterApplicationTest < Minitest::Test

  def test_user_can_register_an_application_with_valid_attributes
    post '/sources', {"identifier" => "JumpstartLabs", "rootUrl" => "http://jumpstartlab.com"}

    assert_equal 1, Client.count
    assert_equal 200, last_response.status
  end

  def test_user_cannot_register_an_application_with_invalid_attributes
    post '/sources', {"identifier" => "JumpstartLabs"}

    assert_equal 0, Client.count
    assert_equal 400, last_response.status
  end

  def test_user_cannot_register_an_application_with_identical_identifier
    post '/sources', {"identifier" => "JumpstartLabs", "rootUrl" => "http://jumpstartlab.com"}
    post '/sources', {"identifier" => "JumpstartLabs", "rootUrl" => "http://jumpstartlab.com"}

    assert_equal 1, Client.count
    assert_equal 403, last_response.status
  end

end
