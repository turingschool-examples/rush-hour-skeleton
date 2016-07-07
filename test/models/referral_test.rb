require_relative '../test_helper'

class ReferralTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_referral_instance
    referral = create_referral
    address = "http://jumpstartlab.com"

    assert_equal address, referral.address
  end

  def test_referral_relationship_to_urls
    create_payload(1)
    referral = Referral.first
    referral.urls << Url.all.first

    refute referral.urls.empty?
    referral.urls.exists?(referral.id)
    assert_equal 1, referral.urls.size
  end

end
