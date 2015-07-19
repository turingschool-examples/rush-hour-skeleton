require './test/test_helper'

class ProcessingRequestsTest < ControllerTest
  def setup
    Site.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
  end

  def test_successful_post_of_payload
    post '/sources/jumpstartlab/data', payload

    assert_equal 200, last_response.status
  end

  def test_missing_payload
    post '/sources/jumpstartlab/data', ""

    assert_equal 400, last_response.status
    assert_equal "Payload is missing", last_response.body
  end

  def test_already_received_payload
    post '/sources/jumpstartlab/data', payload
    post '/sources/jumpstartlab/data', payload

    assert_equal 403, last_response.status
    assert_equal "Payload already received", last_response.body
  end

  def test_application_not_registered
    post '/sources/bad_identifier/data', payload

    assert_equal 403, last_response.status
    assert_equal "Application not registered", last_response.body
  end
end
