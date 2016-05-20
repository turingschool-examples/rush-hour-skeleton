require_relative "../test_helper"

class ResolutionTest < Minitest::Test
  include TestHelpers

  def setup
    @resolution1 = Resolution.create({:height => "1900", :width => "1280"})
    @resolution2 = Resolution.create({:height => "1980", :width => "1100"})
    @resolution3 = Resolution.create({:height => "2200", :width => "1200"})
    @resolution4 = Resolution.create({:height => "2200", :width => ""})
  end

  def test_screen_resolutions_across_all_requests
    res = Resolution.screen_resolutions

    assert_equal [["1280", "1900"], ["1100", "1980"], ["1200", "2200"]], res
  end

  def test_it_validates_new_referrer_with_all_fields
    assert @resolution1.valid?
  end

  def test_it_does_not_validate_new_referrer_with_missing_fields
    refute @resolution4.valid?
  end
end
