require_relative '../test_helper'

class IPTest < Minitest::Test
  include TestHelpers

  def test_can_be_created_with_address
    data = { address: "63.29.38.211" }
    ip = IP.create(data)
    assert_equal "63.29.38.211", ip.address
    assert ip.valid?
  end

  def test_is_invalid_with_missing_ip
    ip = IP.create({ address: nil })
    assert ip.address.nil?
    refute ip.valid?
  end

end
