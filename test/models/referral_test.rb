require_relative '../test_helper'
require './app/models/referral'

class ReferralTest < ModelTest
  def test_it_validates_input
    referral = Referral.new({referred_by: "random url"})

    referral_sad = Referral.new({})
    assert referral.save
    refute referral_sad.save
  end

  def test_it_has_unique_referrals
    referral = Referral.create({referred_by: "random url"})
    referral = Referral.new({referred_by: "random url"})
    refute referral.save
  end
end
