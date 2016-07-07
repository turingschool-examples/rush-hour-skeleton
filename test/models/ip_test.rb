require_relative '../test_helper'

class IpTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_ip_table
    ip = create_ip
    address = "63.29.38.211"

    assert_equal address, ip.address
  end

  def test_ip_relationship_to_payload_requests
    create_payload(1)
    ip = Ip.first
    ip.payload_requests << PayloadRequest.all.first

    refute ip.payload_requests.empty?
    ip.payload_requests.exists?(ip.id)
    assert_equal 1, ip.payload_requests.size
  end
end
