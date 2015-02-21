class IpAddressTest < Minitest::Test
  def test_it_has_correct_attributes
    ip_address = IpAddress.new(:address => "123.45.67.89")
    assert_equal "123.45.67.89", ip_address.address
  end

  def test_it_has_payloads
    ip_address = IpAddress.new(:address => "123.45.67.89")
    assert_equal [], ip_address.payloads
  end
end
