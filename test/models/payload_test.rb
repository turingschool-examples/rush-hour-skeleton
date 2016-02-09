require_relative '../test_helper'

class PayloadTest < Minitest::Test
  def test_responds_to_payloads
    e = Payload.create(ip: "10.10.0.01")

    assert e.respond_to? :payloads
  end

  def test_brings_in_correct_data
    e = Payload.create(ip: "10.10.0.01")

    assert_equal "10.10.0.01", e.ip
  end

  def test_wont_validate_incorrect_data
    e = Payload.create
    assert_nil e.id

    d = Payload.new ip: nil
    assert_nil d.ip
  end
end
