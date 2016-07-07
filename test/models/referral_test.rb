require_relative '../test_helper'

class ReferralTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_referral_instance
    referral = create_referral
    address = "http://jumpstartlab.com"

    assert_equal address, referral.address
  end

end
