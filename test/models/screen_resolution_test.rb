require_relative '../test_helper'

class ScreenResolutionTest < Minitest::Test

    def test_screen_resolution_has_many_payloads
      screen_res = ScreenResolution.new
      assert_equal [], screen_res.payloads
    end

end
