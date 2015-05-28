require_relative '../test_helper'

class ProcessingPayloadTest < ControllerTest
  def test_loads_a_register_source
    post('/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" })
    get('/sources/jumpstartlab')

    assert_equal 200, last_response.status
  end

  def test_returns_error_for_unregistered_source
    get('/sources/idonotexist')

    assert_equal 302, last_response.status
  end
end
