require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  def test_valid_with_resolution_width_and_height
    resolution = Resolution.create(width: "1920", height: "1280")

    assert_equal "1920", resolution.width
    assert_equal "1280", resolution.height
    assert resolution.valid?
  end

  def test_not_valid_without_missing_width
    resolution = Resolution.create(height: "1280")

    refute resolution.width
    assert_equal "1280", resolution.height
    refute resolution.valid?
  end

  def test_not_valid_without_missing_height
    resolution = Resolution.create(width: "1920")

    assert_equal "1920", resolution.width
    refute resolution.height
    refute resolution.valid?
  end
end
