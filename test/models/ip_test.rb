require_relative '../test_helper'

class IpTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_url
    ip = Ip.create(address: "63.29.38.211")
    assert_equal "63.29.38.211", ip.address
  end

  def test_for_uniqness
    Ip.create(address: "63.29.38.2113")
    Ip.create(address: "63.29.38.2115")
    Ip.create(address: "63.29.38.2115")
    assert_equal 2, Ip.count
  end


  def test_doesnt_create_if_missing_field
    Ip.create
    assert_equal 0, Ip.count
  end

  def test_for_relationship_with_payload_request
    create_payload(1)
    payload = PayloadRequest.find(1)
    assert_equal "63.29.38.2110", payload.ip.address
  end


end
