require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_resolution
    res = Resolution.create(height: "15px", width:"20px")

    assert_equal "15px", res.height
    assert_equal "20px", res.width
  end

  def test_all_screen_resolutions_across_all_requests
    res = Resolution.create(height: "1366px", width:"768px")
    res = Resolution.create(height: "1920px", width:"1080px")
    res = Resolution.create(height: "1280px", width:"80px")
    res = Resolution.create(height: "320px", width:"568px")
    res = Resolution.create(height: "1366px", width:"768px")

    expected = "768px x 1366px, 1080px x 1920px, 80px x 1280px, 568px x 320px"
    assert_equal 4, Resolution.count
    assert_equal expected, Resolution.all_screen_resolutions_across_all_requests
  end
end
