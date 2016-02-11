require_relative '../test_helper'

class ReferrerTest < Minitest::Test
  include TestHelpers

  def test_referrer_can_instantiate_with_address
    r = Referrer.new(address: "http://www.kazookidsmom.com")
    assert r.valid?
  end

  def test_referrer_needs_address_to_instantiate
    r = Referrer.new()
    refute r.valid?
  end

  def test_referrer_has_an_address
    r = Referrer.create(address: "http://www.kazookidsmom.com")
    assert_equal "http://www.kazookidsmom.com", r.address
  end

  def test_referrer_has_payload_requests
    r = Referrer.new(address: "http://www.kazookidsmom.com")
    assert_respond_to r, :payload_requests
  end

end
