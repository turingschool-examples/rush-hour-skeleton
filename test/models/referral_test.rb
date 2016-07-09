require_relative '../test_helper'

class ReferralTest < Minitest::Test
  include TestHelpers

  def test_that_it_creates_a_referral_row_with_all_required_data
    ref = Referral.new(name: "https://www.turing.io/")
    assert ref.valid?
  end

  def test_it_does_not_get_created_when_required_info_is_missing
    ref = Referral.new(name: nil)
    refute ref.valid?
  end

  def test_it_has_a_relationship_with_payload_requests
    ref = Referral.new
    assert ref.respond_to?(:payload_requests)
  end

  def test_that_browser_and_os_combination_is_unique_in_table
    ref = Referral.create(name: "https://www.turing.io/")
    ref2 = Referral.create(name: "https://www.turing.io/")
    ref3 = Referral.create(name: "https://www.google.com")

    assert ref.valid?
    refute ref2.valid?
    assert_equal 2, Referral.count
  end

end
