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
    assert_equal "http://jumpstartlab.com/blog", parser.payload[:url]
  end

  def test_parses_requested_at
    assert_equal "2013-02-16 21:38:28 -0700", parser.payload[:requested_at]
  end

  def test_parses_responded_in
    assert_equal 37, parser.payload[:responded_in]
  end

  def test_parses_referred_by
    assert_equal "http://jumpstartlab.com", parser.payload[:referred_by]
  end

  def test_parses_requestType
    assert_equal "GET", parser.payload[:request_type]
  end

  def test_parses_eventName
    assert_equal "socialLogin", parser.payload[:event_name]
  end

  def test_parses_userAgent
    assert_equal "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", parser.payload[:user_agent]
  end

  def test_parses_resolution_width
    assert_equal "1920", parser.payload[:resolution_width]
  end

  def test_parses_resolution_height
    assert_equal "1280", parser.payload[:resolution_height]
  end

  def test_parses_ip
    assert_equal "63.29.38.211", parser.payload[:ip]
  end

  def test_returns_url_table_input
    expected = { url: "http://jumpstartlab.com/blog" }

    assert_equal  expected, parser.url
  end

  def test_returns_screen_resolution_table_input
    expected = { width: "1920", height: "1280"}

    assert_equal expected, parser.screen_resolution
  end

  def test_returns_event_table_input
    expected = "socialLogin"

    assert_equal expected, parser.event[:name]
  end

  def test_returns_browser_table_input
    expected = { name: "Chrome"}

    assert_equal expected, parser.browser
  end

  def test_returns_operating_system_table_input
    expected = { name: "Macintosh%3B Intel Mac OS X 10_8_2"}

    assert_equal expected, parser.operating_system
  end

  def test_returns_nil_when_no_payload
    parser = PayloadParser.new({data: 'no payload'})

    assert_equal nil, parser.payload
  end
end
