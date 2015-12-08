require './test/test_helper'

class RegisterAppTest < ControllerTest
  def test_register_app_with_valid_attributes
    post '/sources', { identifier: "turing", rootUrl: "http://turing.io"}

    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"turing\"}", last_response.body
    assert_equal 1, TrafficSpy::Application.count
  end

  def test_app_registration_fails_without_identifier
    post '/sources', {rootUrl: "http://turing.io"}
    assert_equal 400, last_response.status
    assert_equal "Identifier name can't be blank", last_response.body
    assert_equal 0, TrafficSpy::Application.count
  end

  def test_app_registration_fails_without_url
    post '/sources', {identifier: "turing"}
    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank", last_response.body
    assert_equal 0, TrafficSpy::Application.count
  end 
end 