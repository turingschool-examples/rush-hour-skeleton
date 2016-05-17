require_relative "../test_helper"

class IpAddressTest < Minitest::Test

  def test_it_has_relationship_with_payload_request
    ip = IpAddress.new
    assert_respond_to(ip, :payload_requests)
  end
end
