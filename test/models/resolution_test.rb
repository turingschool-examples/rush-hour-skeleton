require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert ResolutionTest
  end

  # Screen Resolutions across all requests (resolutionWidth x resolutionHeight)
  def test_list_screen_resolutions_across_all_request
    create_payload_1
    create_payload_2
    create_payload_3

    expected = [["960", "1400"], ["1920", "1280"]]
    assert_equal expected, Resolution.screen_resolutions
  end
end
