require './test/test_helper'


class RegistrationTest < ControllerTest

  def test_an_application_registers_and_responds
    post '/sources', { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}
    assert_equal 200, last_response.status
    expected = '{"identifier":"jumpstartlab"}'
    assert_equal expected, last_response.body
  end

  def test_an_application_cannot_register_if_missing_parameter
    post '/sources', { identifier: "jumpstartlab"}
    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank", last_response.body
  end

  def test_an_application_cannot_register_if_identifier_exists
    post '/sources', { identifier: "jumpstartlab", rootUrl: "http://google.com"}
    post '/sources', { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}
    assert_equal 403, last_response.status
    assert_equal "identifier already exists", last_response.body
  end


end
