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

  def test_it_can_create_url_table
    url = create_url
    address = "http://jumpstartlab.com/blog"

    assert_equal address, url.address
    refute_nil? url.referred_by_id
    refute referred_bys.empty?
  end


end
