require './test/test_helper'

class ProcessingTest < ControllerTest
  def test_a_registered_client_can_post_a_valid_payload
    post '/sources', { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }

    post 'sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    assert_equal 200, last_response.status
  end

  def test_rejects_post_if_payload_is_not_identified_properly
    post '/sources', { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }

    post 'sources/jumpstartlab/data', 'stuff={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    assert_equal 400, last_response.status
    assert_equal "Payload missing", last_response.body
  end

  def test_rejects_post_if_payload_is_missing
    post '/sources', { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }

    post 'sources/jumpstartlab/data', {}

    assert_equal 400, last_response.status
    assert_equal "Payload missing", last_response.body
  end

  def test_rejects_post_if_payload_already_received
    post '/sources', { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }

    post 'sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com",
      "requestType":"GET","parameters":[],"eventName":"socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    post 'sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com",
      "requestType":"GET","parameters":[],"eventName":"socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    assert_equal 403, last_response.status
    assert_equal "Payload already received", last_response.body
  end

  def test_rejects_post_when_client_is_not_registered
    post 'sources/coolguyslabs/data', 'payload={"url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com",
      "requestType":"GET","parameters":[],"eventName":"socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    assert_equal 403, last_response.status
    assert_equal "URL not recognized", last_response.body
  end
end
