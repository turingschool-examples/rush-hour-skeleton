require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelper

  def test_it_can_save_resolution
    Resolution.create(width: "1920",
                     height: "1280")

    resolution = Resolution.first

    assert_equal "1920", resolution.width
    assert_equal "1280", resolution.height
  end

  def test_it_doesnt_save_resolution_with_invalid_width
    Resolution.create(height: "1280")

    assert_equal [], Resolution.all.to_a
  end

  def test_it_doesnt_save_resolution_with_invalid_height
    Resolution.create(width: "1920")

    assert_equal [], Resolution.all.to_a
  end

  def test_it_returns_all_resolutions
    Resolution.create(width: "1920",
                     height: "1280")
    Resolution.create(width: "800",
                     height: "600")

    assert_equal ["1920 x 1280", "800 x 600"], Resolution.all_resolutions
  end
end
