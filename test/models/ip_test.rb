require_relative '../test_helper'

class IpTest < Minitest::Test
  include TestHelpers

  def test_can_be_created_with_address
    data = { address: "63.29.38.211" }

    ip = Ip.create(data)

    assert_equal "63.29.38.211", ip.address
    assert ip.valid?
  end

  def test_is_invalid_with_missing_ip
    ip = Ip.create({ address: nil })

    assert ip.address.nil?
    refute ip.valid?
  end

  def test_it_only_adds_unique_data
    data = { address: "63.29.38.211" }

    assert_equal 0, Ip.count

    ip_1 = Ip.create(data)

    assert_equal 1, Ip.count
    assert ip_1.valid?

    ip_2 = Ip.create(data)

    assert_equal 1, Ip.count
    refute ip_2.valid?
  end
end
