require_relative '../test_helper'

class IpAddressTest < Minitest::Test
  include TestHelpers

  def test_has_attributes
    ip_address = IpAddress.new

    assert_respond_to ip_address, :ip
  end

  def test_attribute_must_be_present_when_saving
    ip_address = IpAddress.new

    refute ip_address.save
    refute_equal 1, IpAddress.all.count
  end
end
