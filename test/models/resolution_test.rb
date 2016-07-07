require_relative '../test_helper.rb'

class ResolutionTest < Minitest::Test
  include TestHelpers

  def test_it_can_hold_width_and_height
    resolution = Resolution.create(width: 1280, height: 800)
    assert_equal 1280, resolution.width
    assert_equal 800, resolution.height
    assert resolution.valid?
  end

  # def test_it_can_display_all_screen_resolutions
  #   res_1 = {:width => 1280, :height => 800}
  #   res_2 = {:width => 1024, :height => 768}
  #   Resolution.create(res_1)
  #   Resolution.create(res_2)
  #   assert_equal [1024000, 786432], Resolution.resolutions
  # end
end
