require './test/test_helper'

class IpTest < Minitest::Test

  def teardown
    DatabaseCleaner.clean
  end

  def test_it_has_an_ip_address
    ip = Ip.create({ :ip => "63.29.38.211" })

    assert ip.ip
  end


end