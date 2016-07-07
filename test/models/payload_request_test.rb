require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_it_can_convert_payload_string_to_hash
  result = {
    "url"=>"http://jumpstartlab.com/blog",
    "requestedAt"=>"2013-02-16 21:38:28 -0700",
    "respondedIn"=>37,
    "referredBy"=>"http://jumpstartlab.com",
    "requestType"=>"GET",
    "userAgent"=>
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    "resolutionWidth"=>"1920",
    "resolutionHeight"=>"1280",
    "ip"=>"63.29.38.211"
    }

    assert_equal result, payload
  end

  def test_payload_parser
    assert_equal "http://jumpstartlab.com/blog", payload_parser[:url]
    assert_equal "2013-02-16 21:38:28 -0700", payload_parser[:requested_at]
    assert_equal 37, payload_parser[:responded_in]
    assert_equal "http://jumpstartlab.com", payload_parser[:referral]
    assert_equal "GET", payload_parser[:request_type]
    assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", payload_parser[:software_agent]
    assert_equal "1920", payload_parser[:resolution_width]
    assert_equal "1280", payload_parser[:resolution_height]
    assert_equal "63.29.38.211", payload_parser[:ip]
  end

  # def test_relationships_of_payload_request #WIP
  #   create_payload(1)
  #   url = Url.first
  #   url.payload_requests << PayloadRequest.all.first
  #
  #   refute url.payload_requests.empty?
  #
  #   # assert_instance_of Resolution, payload_request.resolutions.first
  #   # assert_instance_of RequestType, payload_request.request_types.first
  #   # assert_instance_of SoftwareAgent, payload_request.software_agents.first
  #   # assert_instance_of Ip, payload_request.ips.first
  # end

end
