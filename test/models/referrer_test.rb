require_relative "../test_helper"

class ReferrerTest < Minitest::Test
    include TestHelpers

  def setup
    @referrer1 = Referrer.create({:address => "www.google.com"})
    @referrer2 = Referrer.create({:address => ""})
  end

  def test_it_validates_new_referrer_with_all_fields
    assert @referrer1.valid?
  end

  def test_it_does_not_validate_new_referrer_with_missing_fields
    refute @referrer2.valid?
  end


end
