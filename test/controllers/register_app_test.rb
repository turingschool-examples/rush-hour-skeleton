require './test/test_helper'

class RegisterAppTest < ControllerTest
  def test_register_app_with_valid_attributes
    post '/sources', { identifier: "turing", rootUrl: "http://turing.io"}

    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"turing\"}", last_response.body
    assert_equal 1, TrafficSpy::Application.count
  end

  def test_app_registration_fails_without_identifier
# As a guest,
  post '/sources', {rootUrl: "http://turing.io"}
# When I POST to '/sources'
# With no identifier specified,
# Then I receive a 400 response
  assert_equal 400, last_response.status
  assert_equal "No identifier provided.", last_response.body
# And I receive a error message saying I'm missing the identifier
  end
end 