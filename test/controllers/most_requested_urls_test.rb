require './test/test_helper'

class MostRequestedUrlsTest < ControllersTest

  def setup
    post "/sources", { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }
    
    post "/sources/jumpstartlab/data", 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
  end


  def test_minitest
    assert true
  end

  def payload
    '{
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "eventName":"socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"
    }'
  end

  def test_we_can_visit_this_route
    get "/sources/jumpstartlab"
    assert_equal 200, last_response.status
  end

  def test_client_must_be_registered
    get "/sources/not_registered"
    assert_equal 404, last_response.status
  end
end
