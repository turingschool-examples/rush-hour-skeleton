require_relative '../test_helper'
require './app/models/payload_parser'

class PayloadParserTest < ModelTest

  def test_it_corrects_the_system_info
    payload = { :requested_at=>"2013-02-16 21:38:28 -0700",
     :responded_in=>37,
     :referred_by=>"http://jumpstartlab.com",
     :request_type=>"GET",
     :system_information=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
     :resolution_width=>"1920",
     :resolution_height=>"1280",
     :ip=>"63.29.38.211"
    }

    expected = { :requested_at=>"2013-02-16 21:38:28 -0700",
               :responded_in=>37,
               :referred_by=>"http://jumpstartlab.com",
               :request_type=>"GET",
               :browser=>"Chrome",
               :operating_system => "OS X 10.8.2",
               :resolution_width=>"1920",
               :resolution_height=>"1280",
               :ip=>"63.29.38.211"
    }

    parser = PayloadParser.new(payload)
    assert_equal expected, parser.format_agent(payload)
  end

  def test_it_replaces_camel_case_with_snake_case
    payload = {
      "url": "http://jumpstartlab.com/blog",
      "requestedAt": "2013-02-16 21:38:28 -0700",
      "respondedIn": 37,
      "referredBy": "http://jumpstartlab.com",
      "requestType": "GET",
      "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth": "1920",
      "resolutionHeight": "1280",
      "ip": "63.29.38.211"
      }
    parser = PayloadParser.new(payload)
    expected = {
      url: "http://jumpstartlab.com/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by: "http://jumpstartlab.com",
      request_type: "GET",
      browser: "Chrome",
      operating_system: "OS X 10.8.2",
      resolution_width: "1920",
      resolution_height: "1280",
      ip: "63.29.38.211"
      }
    assert_equal expected, parser.replace_keys(payload)
  end


end
