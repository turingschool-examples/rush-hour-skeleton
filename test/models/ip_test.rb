require_relative '../test_helper'

class IpTest < Minitest::Test
  include TestHelpers

  def test_that_it_creates_an_ip_row
    ip = Ip.new(ip_address: "63.29.38.211")
    assert ip.valid?
  end

  def test_it_fails_when_required_info_is_not_entered
    ip = Ip.new(ip_address: nil)
    refute ip.valid?
  end

  def test_it_has_a_relationship_with_payload_requests
    ip = Ip.new
    assert ip.respond_to?(:payload_requests)
  end

  def test_each_ip_is_unique_in_table
    ip = Ip.create(ip_address: "63.29.38.211")
    ip2 = Ip.create(ip_address: "23.29.38.211")
    ip3 = Ip.create(ip_address: "63.29.38.211")

    assert ip.valid?
    assert ip2.valid?
    refute ip3.valid?
    assert_equal 2, Ip.count
  end
end
