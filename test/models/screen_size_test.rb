require_relative '../test_helper'

class ScreenSizeTest < Minitest::Test

  include TestHelpers

  def test_it_returns_false_when_no_width_is_entered
    screen_size = ScreenSize.new({ resolution_height: "1920" })
    refute screen_size.save
  end

  def test_it_returns_false_when_no_height_is_entered
    screen_size = ScreenSize.new({ resolution_width: "1280" })
    refute screen_size.save
  end

  def test_it_returns_true_when_all_information_is_entered
    screen_size = ScreenSize.new({ resolution_height: "1920", resolution_width: "1280" })
    assert screen_size.save
  end

  def test_it_can_return_all_screen_resolutions
    ScreenSize.create({ resolution_height: "1920", resolution_width: "1280" })
    ScreenSize.create({ resolution_height: "1280", resolution_width: "800" })
    ScreenSize.create({ resolution_height: "1920", resolution_width: "1280" })
    ScreenSize.create({ resolution_height: "1600", resolution_width: "800" })

    assert_equal ["1600 x 800", "1920 x 1280", "1280 x 800"], ScreenSize.all_screen_sizes
  end

end
