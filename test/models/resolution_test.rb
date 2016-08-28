require_relative '../test_helper'
require "pry"

class ResolutionTest < Minitest::Test
  include TestHelpers

  def test_it_validates_resolution
    resolution = Resolution.create(height: 1920, width: 3000)
    resolution2 = Resolution.create(height: 1920)

    assert_equal 1920, resolution.height
    assert resolution.valid?
    refute resolution2.valid?
    assert_equal 1, Resolution.all.count
  end
end
