require_relative "../test_helper"

class ResolutionTest < Minitest::Test
  include TestHelpers

  def setup
    Resolution.create({:height => "1900", :width => "1280"})
    Resolution.create({:height => "1980", :width => "1100"})
    Resolution.create({:height => "2200", :width => "1200"})
  end

  def test_screen_resolutions_across_all_requests
    res = Resolution.screen_resolutions

    assert_equal [["1280", "1900"], ["1100", "1980"], ["1200", "2200"]], res
  end



end
