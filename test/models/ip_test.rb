require_relative '../test_helper'

class IpTest < Minitest::Test
  include TestHelpers
  
  def test_it_can_create_ip_table
    ip = create_ip
    address = "63.29.38.211"

    assert_equal address, ip.address
  end

end
