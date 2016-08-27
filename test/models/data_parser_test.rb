require_relative '../test_helper'

class DataParserTest < Minitest::Test
  include DataParser
  def raw_payload
    '{
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
  end

  def test_it_parses_raw_json
    parsed = parsed(raw_payload)

    expected = {"url"=>"http://jumpstartlab.com/blog",
                   "requestedAt"=>"2013-02-16 21:38:28 -0700",
                   "respondedIn"=>37,
                   "referredBy"=>"http://jumpstartlab.com",
                    "requestType"=>"GET",
                    "userAgent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                    "resolutionWidth"=>"1920",
                    "resolutionHeight"=>"1280",
                    "ip"=>"63.29.38.211"}

    assert_equal expected, parsed
  end

  def test_it_reassigns_column_keys_to_snake_case

    expected = {"url"=>"http://jumpstartlab.com/blog",
                   "requested_at"=>"2013-02-16 21:38:28 -0700",
                   "responded_in"=>37,
                   "referred_by"=>"http://jumpstartlab.com",
                    "request_type"=>"GET",
                    "u_agent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                    "resolution_width"=>"1920",
                    "resolution_height"=>"1280",
                    "ip"=>"63.29.38.211"}

    assert_equal expected, formatted_payload(raw_payload)
  end

  def test_it_parses_client_string
    raw_client = 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    expected = {"identifier" => "jumpstartlab", "root_url" => "http://jumpstartlab.com"}

    assert_equal expected, formatted_client(raw_client)
  end
end
