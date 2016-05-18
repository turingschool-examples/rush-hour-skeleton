require_relative '../test_helper'

class PayloadParserTest < Minitest::Test
  def setup
    @p = PayloadParser.new

    @payload =
    {
     "url" => "http://jumpstartlab.com/blog",
     "requestedAt" => "2013-02-16 21:38:28 -0700",
     "respondedIn" => 37,
     "referredBy" => "http://jumpstartlab.com",
     "requestType" => "GET",
     "parameters" => [],
     "eventName" =>  "socialLogin",
     "userAgent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
     "resolutionWidth" => "1920",
     "resolutionHeight" => "1280",
     "ip" => "63.29.38.211"
    }

    output =
    {
      "url" => "http://jumpstartlab.com/blog",
      "requested_at" => "2013-02-16 21:38:28 -0700",
      "responded_in" => 37,
      "reference" => "http://jumpstartlab.com",
      "request_type" => "GET",
      "parameters" => [],
      "event_name" =>  "socialLogin",
      "os" => "Macintosh; Intel Mac OS X 10_8_2",
      "browser" => "hi",
      "user_agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolution_width" => "1920",
      "resolution_height" => "1280",
      "ip_address" => "63.29.38.211"
    }
  end

  def test_it_can_parse_from_JSON_to_a_hash
    input =
    '{
     "url":"http://jumpstartlab.com/blog",
     "requestedAt":"2013-02-16 21:38:28 -0700",
     "respondedIn":37,
     "referredBy":"http://jumpstartlab.com",
     "requestType":"GET",
     "parameters":[],
     "eventName": "socialLogin",
     "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
     "resolutionWidth":"1920",
     "resolutionHeight":"1280",
     "ip":"63.29.38.211"
    }'

    payload =
    {
     "url" => "http://jumpstartlab.com/blog",
     "requestedAt" => "2013-02-16 21:38:28 -0700",
     "respondedIn" => 37,
     "referredBy" => "http://jumpstartlab.com",
     "requestType" => "GET",
     "parameters" => [],
     "eventName" =>  "socialLogin",
     "userAgent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
     "resolutionWidth" => "1920",
     "resolutionHeight" => "1280",
     "ip" => "63.29.38.211"
    }

    assert_equal payload, @p.parse_json(input)
  end

  def test_it_can_populate_the_urls_table
    urls = @p.populate_urls(@payload)
    assert_equal "http://jumpstartlab.com/blog", urls.url
  end

  def test_it_can_populate_the_references_table
    references = @p.populate_references(@payload)
    assert_equal "http://jumpstartlab.com", references.reference
  end

  def test_it_can_populate_request_types_table
    request = @p.populate_request_types(@payload)
    assert_equal "GET", request.request_type
  end

  def test_it_can_populate_the_event_name_table
    event_names = @p.populate_event_names(@payload)
    assert_equal "socialLogin", event_names.event_name
  end

  def test_it_can_populate_user_agents_table
    agents = @p.populate_user_agents(@payload)
    assert_equal "Chrome", agents.browser
    assert_equal "", agents.os
  end

  def test_it_can_populate_the_resolutions_table
    resolutions = @p.populate_resolutions(@payload)
    assert_equal "1920", resolutions.resolution_width
    assert_equal "1280", resolutions.resolution_height
  end

  def test_it_can_populate_the_ip_addresses_table

  end


end
