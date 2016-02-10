require_relative '../test_helper'

class ReferTest < Minitest::Test
  def test_responds_to_payloads
    e = Refer.create(address: "http://www.google.com")

    assert e.respond_to? :payloads
  end

  def test_brings_in_correct_data
    e = Refer.create(address: "http://www.google.com")

    assert_equal "http://www.google.com", e.address
  end

  def test_wont_validate_incorrect_data
    e = Refer.create
    assert_nil e.id

    d = Refer.new address: nil
    assert_nil d.address
  end
end
