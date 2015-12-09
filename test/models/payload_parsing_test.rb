require_relative '../test_helper'

class PayloadParserTest < TrafficTest

  def register_user
    parser_setup({"rootUrl"=>"http://turing.io", "identifier"=>"turing"}).parsing_validating
  end

  def payload_params
    {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}
  end

  def parser_setup(params)
    @parser = TrafficSpy::RegistrationParser.new(params)
  end

  def test_payload_parser_parses_properly
    payload_parser = TrafficSpy::PayloadParser.new(payload_params)
    assert_equal "http://jumpstartlab.com/blog", payload_parser.url
    assert_equal "2013-02-16 21:38:28 -0700", payload_parser.requested_at
    assert_equal 37, payload_parser.responded_in
    assert_equal "http://jumpstartlab.com", payload_parser.referred_by
    assert_equal "GET", payload_parser.request_type
    assert_equal [], payload_parser.parameters
    assert_equal "socialLogin", payload_parser.event_name
    assert_equal "Chrome", payload_parser.browser
    assert_equal "63.29.38.211", payload_parser.ip
    assert_equal "c3ad59dad6b3e71f080c78cd358024898dcab74d", payload_parser.payload_sha
    assert_equal "Macintosh", payload_parser.os
  end


end
