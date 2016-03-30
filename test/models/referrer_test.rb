require_relative '../test_helper'

class ReferrerTest < Minitest::Test
  include TestHelpers

  def test_it_can_accept_referrer
    referrer = Referrer.create(address: "http://jumpstartlab.com")

    assert_equal "http://jumpstartlab.com", referrer.address
  end

  def test_it_checks_for_empty_address
    referrer = Referrer.create(address: nil)

    assert_nil referrer.address
  end
  def test_it_responds_with_an_error_message
    referrer = Referrer.create(address: nil)

    assert_equal "can't be blank", referrer.errors.messages[:address][0]
  end
end
