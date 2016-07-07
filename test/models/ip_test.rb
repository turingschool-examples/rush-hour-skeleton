require_relative '../test_helper'

class IpTest < Minitest::Test

  def test_it_can_create_url
    ip = Ip.create(address: "63.29.38.211")
    assert_equal "63.29.38.211", ip.address
  end

end
