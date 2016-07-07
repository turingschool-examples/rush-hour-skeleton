require_relative '../test_helper'

class ReferralTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_referral_instance
    referral = create_referral
    address = "63.29.38.211"

    assert_equal address, referral.address
  end

end
