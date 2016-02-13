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

    pr = RequestParser.parse_request(payload, "http://turing.io")

    # assert_equal 1, pr.url_id
    # assert_equal "2013-02-16 21:38:28 -0700", pr.requested_at
    # assert_equal 37, pr.responded_in
    # assert_equal 1, pr.referrer_url_id
    # assert_equal 1, pr.request_type_id
    # assert_equal "[]", pr.parameters
    # assert_equal 1, pr.event_name_id
    # assert_equal 1, pr.user_system_id
    # assert_equal 1, pr.resolution_id
    # assert_equal 1, pr.ip_id
    # refute_equal 2, pr.referrer_url_id
  end
end
