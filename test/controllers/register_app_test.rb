require './test/test_helper'

class RegisterAppTest < ControllerTest
  def test_register_app_with_valid_attributes
    post '/sources', { identifier: "turing", rootUrl: "http://turing.io"}

    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"turing\"}", last_response.body
    assert_equal 1, TrafficSpy::Application.count
  end
end
