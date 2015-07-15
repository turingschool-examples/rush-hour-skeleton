require './test/test_helper.rb'

class ProcessingRequestsTest < ControllerTest

  def test_request_with_unique_payload_returns_200_ok
    register_application
    post '/sources/jumpstartlab/data', payload
    assert_equal 200, last_response.status
  end

  def test_request_missing_payload_returns_400_bad_request
    register_application
    post '/sources/jumpstartlab/data' 
    assert_equal 400, last_response.status
    assert_equal 'missing payload', last_response.body
  end

  def test_repeated_reqest_returns_403_forbidden
    register_application
    post '/sources/jumpstartlab/data', payload
    post '/sources/jumpstartlab/data', payload
    assert_equal 403, last_response.status 
    assert_equal 'already received request', last_response.body
  end

  def test_request_from_not_registered_url_returns_403_forbidden
    post '/sources/not_registered_url/data', payload
    assert_equal 403, last_response.status
    assert_equal 'application not registered', last_response.body
  end

  private

  def register_application
    TrafficSpy::Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
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
      "ip":"63.29.38.211" }.to_json 
    }
  end


end
