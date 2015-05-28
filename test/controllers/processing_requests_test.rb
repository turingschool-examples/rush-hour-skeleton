require './test/test_helper'
require 'json'

class ProcessingRequestTest < ControllersTest
  def test_it_exists
    assert_equal 2, 1+1
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

  def test_a_payload_can_be_received
    post "/sources", { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }
    post "/sources/1/data", JSON.parse(payload)
    assert_equal 200, last_response.status
    # assert_equal "", last_response.body
  end
end
