require_relative '../test_helper'
require_relative '../../app/lib/request_parser'
require 'pry'

class RequestParserTest < Minitest::Test
  include TestHelpers

  def test_parser_correctly_renames_keys
    payload = '{
    "url":"http://turing.io/blog",
    "requestedAt":"2013-02-16 21:38:28 -0700",
    "respondedIn":37,
    "referredBy":"http://turing.io",
    "requestType":"GET",
    "parameters":[],
    "eventName": "socialLogin",
    "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    "resolutionWidth":"1920",
    "resolutionHeight":"1280",
    "ip":"63.29.38.211"
    }'
    Client.create(identifier: "google", root_url: "http://google.com")

    RequestParser.parse_request(payload, "google")
    pr = PayloadRequest

    assert_equal 1, pr.pluck(:url_id)[0]
    assert_equal "2013-02-16 21:38:28 -0700", pr.pluck(:requested_at)[0]
    assert_equal 37, pr.pluck(:responded_in)[0]
    assert_equal 1, pr.pluck(:referrer_url_id)[0]
    assert_equal 1, pr.pluck(:request_type_id)[0]
    assert_equal "[]", pr.pluck(:parameters)[0]
    assert_equal 1, pr.pluck(:event_name_id)[0]
    assert_equal 1, pr.pluck(:user_system_id)[0]
    assert_equal 1, pr.pluck(:resolution_id)[0]
    assert_equal 1, pr.pluck(:ip_id)[0]
    refute_equal 2, pr.pluck(:referrer_url_id)[0]
  end
end
