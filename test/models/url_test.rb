require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_url_instance
    url = create_url
    address = "http://jumpstartlab.com/blog"

    assert_equal address, url.address
    refute_nil url.referral_id
  end

  def test_url_relationship_to_payload_requests
    create_payload(1)
    url = Url.first
    url.payload_requests << PayloadRequest.all.first

    refute url.payload_requests.empty?
    url.payload_requests.exists?(url.id)
    assert_equal 1, url.payload_requests.size
  end
end
