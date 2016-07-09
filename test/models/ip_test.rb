require_relative '../test_helper'

class IpTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_ip_table
    ip = create_ip
    address = "63.29.38.211"

    assert_equal address, ip.address
  end

  def test_ip_relationship_to_payload_requests
    three_relationship_requests
    ip = Ip.first
    ip.payload_requests << PayloadRequest.all.first

    assert ip.respond_to?(:payload_requests)
    assert_instance_of PayloadRequest, ip.payload_requests.first
  end

  def test_it_cannot_create_ip_without_address
    ip = Ip.new({})

    refute ip.valid?
  end

end
