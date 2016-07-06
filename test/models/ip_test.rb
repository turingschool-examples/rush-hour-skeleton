#when without an ip address, dont' want this to be created.

require_relative '../test_helper'

class IpTest < Minitest::Test
  def test_that_it_creates_a_ip_row
    ip = Ip.new(ip_address: "63.29.38.211" )
    assert ip.valid?
  end

end
