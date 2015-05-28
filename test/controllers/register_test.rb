require './test/test_helper'

class RegisterTest < ControllerTest
  def test_registers_a_client_with_valid_request
    post '/sources', { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }

    assert_equal 200, last_response.status
    assert_equal ({identifier: 'jumpstartlab'}.to_json), last_response.body
  end

  def test_rejects_request_without_identifier
    post '/sources', { rootUrl: "http://jumpstartlab.com" }

    assert_equal 400, last_response.status
    assert_equal "Make sure you enter an identifier", last_response.body
  end

  def test_rejects_request_without_root_url
    post '/sources', { identifier: "jumpstartlab" }

    assert_equal 400, last_response.status
    assert_equal "Make sure you enter a rootUrl", last_response.body
  end

  def test_rejects_request_without_any_params
    post '/sources'

    assert_equal 400, last_response.status
    assert_equal "Please enter an identifier and rootUrl", last_response.body
  end

  def test_rejects_request_that_already_exists_in_db
    post '/sources', { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }

    post '/sources', { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }
    assert_equal 403, last_response.status
    assert_equal "Identifier already exists", last_response.body
  end
end
