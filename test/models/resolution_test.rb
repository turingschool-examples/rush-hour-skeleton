require_relative '../test_helper'

class ResolutionTest < Minitest::Test

  def test_it_can_create_resolution
    nums = Resolution.create(height: "15px", width:"20px")
    assert_equal "15px", nums.height
    assert_equal "20px", nums.width
  end
end
