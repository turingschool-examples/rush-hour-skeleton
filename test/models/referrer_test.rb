require_relative '../test_helper'

class ReferrerTest < Minitest::Test
  include TestHelpers

  def test_it_has_referred_by_attribute
    referrer = Referrer.new

    assert_respond_to referrer, :referredBy
  end
end
