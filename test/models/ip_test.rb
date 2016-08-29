require_relative '../test_helper'

class IpTest < Minitest::Test
  include TestHelpers

  def test_it_validates_ip
    ip = Ip.create(ip_address: "128.345.567.458")

    assert ip.valid?

    assert_equal 1, Ip.all.count
  end
end
