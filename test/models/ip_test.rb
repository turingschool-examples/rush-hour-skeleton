require_relative '../test_helper.rb'

class IpTest < Minitest::Test
  include TestHelpers

  def test_it_holds_an_address
    ip = Ip.create(address: "1.2.3.4.5")

    assert_equal "1.2.3.4.5", ip.address
  end
end
