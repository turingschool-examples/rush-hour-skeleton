require_relative '../test_helper'
require './app/models/payload_parser'

class PayloadParserTest < Minitest::Test
  def test_it_replaces_camel_case_with_snake_case
    payload = '{
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"
      }'
    parser = PayloadParser.new(payload)
    expected = '{
      "url":"http://jumpstartlab.com/blog",
      "requested_at":"2013-02-16 21:38:28 -0700",
      "responded_in":37,
      "referred_by":"http://jumpstartlab.com",
      "request_type":"GET",
      "user_agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolution_width":"1920",
      "resolution_height":"1280",
      "ip":"63.29.38.211"
      }'

      assert_equal expected, parser.replace(payload)
  end

  # def test_it_can_parse_the_payload_with_JSON
  #
  #   assert_
  # end

end
