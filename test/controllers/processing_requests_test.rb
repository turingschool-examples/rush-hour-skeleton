require './test/test_helper'

class ProcessingRequestsTest < ControllerTest
  def setup
    post '/sources', { identifier: "jumpstartlab", root_url: "http://jumpstartlab.com"}

    payload[:identifier] = "jumpstartlab"
    payload[:root_url] = "http://jumpstartlab.com"
  end

  def payload
    { payload: {
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName": "socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"
    }}
  end

  def test_successful_post_of_payload
    post 'sources/jumpstartlab/data', payload

    assert_equal 200, last_response.status
  end

  def test_missing_payload
    post 'sources/jumpstartlab/data', ""

    assert_equal 400, last_response.status
    assert_equal "Payload is missing", last_response.body
  end

  def test_already_received_payload
    post 'sources/jumpstartlab/data', payload
    post 'sources/jumpstartlab/data', payload

    assert_equal 403, last_response.status
    assert_equal "Payload already received", last_response.body
  end

  def test_application_not_registered
    post 'sources/bad_identifier/data', payload

    assert_equal 403, last_response.status
    assert_equal "Application not registered", last_response.body
  end
end
