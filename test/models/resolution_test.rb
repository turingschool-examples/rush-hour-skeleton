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

end
