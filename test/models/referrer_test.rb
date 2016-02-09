require_relative '../test_helper'

class ReferrerTest < Minitest::Test
  include TestHelpers

  def test_it_has_referred_by_attribute
    referrer = Referrer.new

    assert_respond_to referrer, :referredBy
  end

  def test_attribute_must_be_present_when_saving
    referrer = Referrer.new

    refute referrer.save
    refute_equal 1, Referrer.all.size
  end
end
