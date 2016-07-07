require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_resolution_instance
    resolution = create_resolution
    width = "1920"
    height = "1280"

    assert_equal width, resolution.width
    assert_equal height, resolution.height
  end

end
