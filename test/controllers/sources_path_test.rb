require_relative '../test_helper'

class SourcesPathTest < ControllerTest

  def test_registration_returns_400_when_missing_identifier_parameter
    post '/sources', {url: "things"}
    assert_equal 400, last_response.status
    assert_equal "Missing Parameters - 400 Bad Request", last_response.body
  end

  def test_registration_returns_400_when_missing_root_url_parameter
    post '/sources', {identifier: "things and stuff"}
    assert_equal 400, last_response.status
    assert_equal "Missing Parameters - 400 Bad Request", last_response.body
  end

  def test_registration_is_successful
    post '/sources', {url: "other things", identifier: "things and stuff"}
    assert_equal 200, last_response.status
    assert_equal "{'identifier' : 'things and stuff'}", last_response.body
  end

end
