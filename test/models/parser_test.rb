require_relative '../test_helper'

class ParserTest< Minitest::Test


  def test_it_can_parse_for_requested_at_column
    assert_equal "2013-02-16 21:38:28 -0700", Parser.parse(the_payload)[:requested_at]
  end

  def the_payload
    "parser="+@payload
  end

  def test_it_can_parse_for_responded_in_column
    assert_equal 37, Parser.parse(the_payload)[:responded_in]
  end

  def test_it_can_parse_for_referredBy_in_column
    assert_equal "http://jumpstartlab.com", Parser.parse(the_payload)[:referred_by]

  end

  def test_it_can_parse_for_requestType_in_column
    assert_equal "GET", Parser.parse(the_payload)[:request_type]

  end

  def test_it_can_parse_for_eventName_in_column
    assert_equal "socialLogin", Parser.parse(the_payload)[:event_name]

  end

  def test_it_can_parse_for_userAgent_in_column
    assert_equal "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", Parser.parse(the_payload)[:user_agent]
  end

  def test_it_can_parse_for_resolutionWidth_in_column
    assert_equal "1920", Parser.parse(the_payload)[:resolution_width]

  end

  def test_it_can_parse_for_resolutionHeight_in_column
    assert_equal "1280", Parser.parse(the_payload)[:resolution_height]
  end
end
