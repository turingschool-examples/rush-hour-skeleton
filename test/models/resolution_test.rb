require_relative '../test_helper.rb'

class ResolutionTest < Minitest::Test
  include TestHelpers

  def test_it_can_hold_width_and_height
    resolution = Resolution.create(width: 1280, height: 800)
    assert_equal 1280, resolution.width
    assert_equal 800, resolution.height
    assert resolution.valid?
  end
end
