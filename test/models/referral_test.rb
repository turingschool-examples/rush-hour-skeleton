require_relative '../test_helper'
require './app/models/referral'

class ReferralTest < Minitest::Test
  def test_it_validates_input
    referral = Referral.new({referred_by: "random url"})

    referral_sad = Referral.new({})
    assert referral.save
    refute referral_sad.save
  end
end