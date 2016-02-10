require_relative '../test_helper'

class PayloadParserTest < Minitest::Test
  include TestHelpers

  def test_parser_can_create_a_valid_payload_request_input
    pr = PayloadRequest.new(PayloadParser.parse(example_payload))
    assert pr.save

    assert_equal "http://jumpstartlab.com/blog", pr.url.address
    assert_equal "2013-02-16 21:38:28 -0700", pr.requested_at
    assert_equal 37, pr.responded_in
    assert_equal "http://jumpstartlab.com", pr.referrer.address
    assert_equal "GET", pr.request.verb
    assert_equal "socialLogin", pr.event.name
    assert_equal "Chrome", pr.user_agent.browser
    assert_equal "Mac OS X 10.8.2", pr.user_agent.platform
    assert_equal "1920", pr.resolution.width
    assert_equal "1280", pr.resolution.height
    assert_equal "63.29.38.211", pr.ip.address
  end

  def example_payload
    ({
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
    })
  end

end
