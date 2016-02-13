require_relative '../test_helper'

class IpTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert Ip
  end

  def test_can_create_ip_through_payload_request
    pr = create_payload_1

    assert_equal "63.29.38.211", Ip.find(1).ip_address
    assert_equal 1, pr.ip_id
  end

  def test_can_create_ip_addresses
    ip_addy = {ip_address: "63.29.38.211"}
    ip = Ip.create(ip_addy)

    assert ip.valid?
    assert_equal "63.29.38.211", ip.ip_address
    assert_equal 1, ip.id
  end

  def test_the_same_ip_address_will_not_be_added_to_database
    ip_addy = {ip_address: "63.29.38.211"}
    ip = Ip.create(ip_addy)

    assert_equal 1, Ip.all.count

    ip_addy2 = {ip_address: "63.29.38.211"}
    ip2 = Ip.create(ip_addy2)

    refute ip2.valid?
    assert ip2.id.nil?
    assert_equal 1, Ip.all.count
  end
end
