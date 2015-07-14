require './test/test_helper'


class RegistrationTest < ControllerTest

  def test_an_application_registers_and_responds
    post '/sources', { identifier: "jumpstartlab", root_url: "http://jumpstartlab.com"}
    assert_equal 200, last_response.status
    expected = '{"identifier":"jumpstartlab"}'
    assert_equal expected, last_response.body
  end

  def test_an_application_cannot_register_if_missing_parameter
    skip
    post '/sources', { identifier: "jumpstartlab"}
    assert_equal 400, last_response.status
    assert_equal "missing parameters", last_response.body
  end

  def test_an_application_cannot_register_if_id_exists
    skip
    post '/sources', { identifier: "jumpstartlab", root_url: "http://jumpstartlab.com"}
    post '/sources', { identifier: "jumpstartlab", root_url: "http://umpstartlab.com"}
  end


end
