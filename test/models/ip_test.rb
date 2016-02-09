require_relative '../test_helper'

class IpTest < Minitest::Test
  def test_responds_to_payloads
    e = Ip.create(ip: "10.10.0.01")

    assert e.respond_to? :payloads
  end

  def test_brings_in_correct_data
    e = Ip.create(ip: "10.10.0.01")

    assert_equal "10.10.0.01", e.ip
  end

  def test_wont_validate_incorrect_data
    e = Ip.create
    assert_nil e.id

    d = Ip.new ip: nil
    assert_nil d.ip
  end
end
