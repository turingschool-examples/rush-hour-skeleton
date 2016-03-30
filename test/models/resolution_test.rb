require_relative '../test_helper'
class ResolutionTest < Minitest::Test
  include TestHelpers

  def test_it_can_accept_resolution
    resolution = Resolution.create(width: "1920", height: "1280")

    assert_equal "1920", resolution.width
    assert_equal "1280", resolution.height
  end

  def test_it_checks_for_empty_width
    resolution = Resolution.create(width: nil, height: nil)

    assert_nil resolution.width
    assert_nil resolution.height
  end

  def test_it_responds_with_an_error_message
    resolution = Resolution.create(width: nil, height: nil)

    assert_equal "can't be blank", resolution.errors.messages[:width][0]
    assert_equal "can't be blank", resolution.errors.messages[:height][0]
  end

  def test_returns_resolutions_across_all_requests
    setup_data

    assert_equal ["2560 X 1440", "1920 X 1280"],  Resolution.resolutions_across_all_requests
  end
end
