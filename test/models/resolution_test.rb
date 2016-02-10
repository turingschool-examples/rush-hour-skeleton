require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelpers

  def test_has_attributes
    resolution = Resolution.new

    assert_respond_to resolution, :resolution_width
    assert_respond_to resolution, :resolution_height
  end

  def test_does_not_save_with_empty_attributes
    resolution = Resolution.new

    refute resolution.save
    refute_equal 1, Resolution.all.count
  end
end
