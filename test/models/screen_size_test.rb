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


end
