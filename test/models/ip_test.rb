require_relative "../test_helper"

class IpTest < Minitest::Test
  include TestHelper

  def test_it_can_save_an_ip
    Ip.create(address: "63.29.38.211")

    ip = Ip.first

    assert_equal "63.29.38.211", ip.address
  end

  def test_it_doesnt_save_ip_with_invalid_ip
    Ip.create()

    assert_equal [], Ip.all.to_a
  end
end
