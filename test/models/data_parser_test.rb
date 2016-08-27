require_relative '../test_helper'

class DataParserTest < Minitest::Test
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

  def raw_client_payload_data1
    {"payload"=>"{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}", "splat"=>[], "captures"=>["jumpstartlab"], "identifier"=>"jumpstartlab"}
  end

  def test_it_parses_raw_json
    payload = DataParser.new(raw_client_payload_data1)
    parsed = payload.parsed_payload

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
    payload = DataParser.new(raw_client_payload_data1)
    parsed = payload.formatted_payload
    expected = {"url"=>"http://jumpstartlab.com/blog",
                   "requested_at"=>"2013-02-16 21:38:28 -0700",
                   "responded_in"=>37,
                   "referred_by"=>"http://jumpstartlab.com",
                    "request_type"=>"GET",
                    "u_agent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                    "resolution_width"=>"1920",
                    "resolution_height"=>"1280",
                    "ip"=>"63.29.38.211"}

    assert_equal expected, parsed
  end

  def test_it_parses_client_string
    raw_client = {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}
    client = DataParser.new(raw_client)
    expected = {"identifier" => "jumpstartlab", "root_url" => "http://jumpstartlab.com"}

    assert_equal expected, client.formatted_client
  end

  def test_it_can_assign_payload_request_foreign_keys
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")

    expected = PayloadRequest.find(1)
    parsed_payload = DataParser.new(raw_client_payload_data1)

    assert_equal expected, parsed_payload.assign_foreign_keys
  end

  def test_it_checks_for_payload_uniqueness
    skip
    raw_payload = raw_client_payload_data1["payload"]
    parsed_payload = DataParser.new(raw_payload)


  end
end
