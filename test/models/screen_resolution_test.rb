require_relative '../test_helper'

class ScreenResolutionTest < Minitest::Test
  include TestHelpers

  def test_screen_resolution_breakdown
    create_payloads(4)
    assert_equal ["1920x1280", "1920x1080"], ScreenResolution.screen_resolution_breakdown
  end

end
