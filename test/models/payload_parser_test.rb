require_relative '../test_helper'

class PayloadParserTest < Minitest::Test

  attr_reader :parser

  def raw_params
    @input_json = "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"

    { payload: @input_json }
  end

  def setup
    super
    @parser = PayloadParser.new(raw_params)
  end

  def test_parses_url
    assert_equal "http://jumpstartlab.com/blog", parser.parse[:url]
  end

  def test_parses_requested_at
    assert_equal "2013-02-16 21:38:28 -0700", parser.parse[:requested_at]
  end

  def test_parses_responded_in
    assert_equal 37, parser.parse[:responded_in]
  end

  def test_parses_referred_by
    assert_equal "http://jumpstartlab.com", parser.parse[:referred_by]
  end

  def test_parses_requestType
    assert_equal "GET", parser.parse[:request_type]
  end

  def test_parses_eventName
    assert_equal "socialLogin", parser.parse[:event_name]
  end

  def test_parses_userAgent
    assert_equal "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", parser.parse[:user_agent]
  end

  def test_parses_resolution_width
    assert_equal "1920", parser.parse[:resolution_width]
  end

  def test_parses_resolution_height
    assert_equal "1280", parser.parse[:resolution_height]
  end

  def test_parses_ip
    assert_equal "63.29.38.211", parser.parse[:ip]
  end

  def test_returns_url_table_data
    expected = { url: "http://jumpstartlab.com/blog" }


    assert_equal  expected, parser.url
  end
end
