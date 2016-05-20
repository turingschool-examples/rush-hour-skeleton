require_relative '../test_helper'

class ParserTest < Minitest::Test
  include TestHelpers

  def test_it_can_parse_a_user_agent
    user_agent_string = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.56 Safari/536.5'
    result = Parser.parse_user_agent(user_agent_string)

    assert_equal "Chrome", result.browser
    assert_equal "Macintosh", result.platform
  end

  def test_it_can_parse_json
    json_string = '{"key": "value"}'
    result = Parser.parse_json(json_string)

    assert_equal "value", result["key"]
  end

  def test_it_can_parse_a_raw_json_payload
    payload = '{"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
    result = Parser.parse_payload(payload)

    assert_equal "http://jumpstartlab.com/blog", result["url"]
    assert_equal "2013-02-16 21:38:28 -0700", result["requestedAt"]
    assert_equal 37, result["respondedIn"]
    assert_equal "http://jumpstartlab.com", result["referredBy"]
    assert_equal "GET", result["requestType"]
    assert_equal [], result["parameters"]
    assert_equal "socialLogin", result["eventName"]
    assert_equal "Chrome", result["userAgent"].browser
    assert_equal "Macintosh%3B Intel Mac OS X 10_8_2", result["userAgent"].platform

  end
end
