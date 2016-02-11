require_relative '../test_helper'

class IpTest < Minitest::Test
  include TestHelpers
  
  def test_responds_to_payloads
    e = Ip.create(address: "10.10.0.01")

    assert e.respond_to? :payloads
  end

  def test_brings_in_correct_data
    e = Ip.create(address: "10.10.0.01")

    assert_equal "10.10.0.01", e.address
  end

  def test_wont_validate_incorrect_data
    e = Ip.create
    assert_nil e.id

    d = Ip.new address: nil
    assert_nil d.address
  end
end
