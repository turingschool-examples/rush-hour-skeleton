require_relative '../test_helper'

class PayloadParserTest < Minitest::Test
  include TestHelpers
  def setup
    @payload =
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
    pp = PayloadParser.new(input)

    assert_equal payload, pp.payload
  end

  def test_it_can_populate_the_urls_table
    pp = PayloadParser.new(@payload)

    urls = pp.populate_urls
    assert_equal "http://jumpstartlab.com/blog", urls.url
  end

  def test_it_can_populate_the_references_table
    pp = PayloadParser.new(@payload)
    references = pp.populate_references
    assert_equal "http://jumpstartlab.com", references.reference
  end

  def test_it_can_populate_request_types_table
    pp = PayloadParser.new(@payload)
    request = pp.populate_request_types
    assert_equal "GET", request.request_type
  end

  def test_it_can_populate_the_event_name_table
    pp = PayloadParser.new(@payload)
    event_names = pp.populate_event_names
    assert_equal "socialLogin", event_names.event_name
  end

  def test_it_can_populate_user_agents_table
    pp = PayloadParser.new(@payload)
    agents = pp.populate_software_agents
    assert_equal "Chrome", agents.browser
    assert_equal "OS X 10.8.2", agents.os
  end

  def test_it_can_populate_the_resolutions_table
    pp = PayloadParser.new(@payload)
    resolutions = pp.populate_resolutions
    assert_equal "1920", resolutions.resolution_width
    assert_equal "1280", resolutions.resolution_height
  end

  def test_it_can_populate_ip_addresses_table
    pp = PayloadParser.new(@payload)
    ips = pp.populate_ip_addresses
    assert_equal "63.29.38.211", ips.ip_address
  end

  def test_it_can_populate_all_the_tables
    payloads = create_payloads(2)
    payloads.each do |payload|
      PayloadParser.new(payload)
    end
    assert_equal 2, PayloadRequest.count
  end


end
