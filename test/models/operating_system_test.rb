require_relative '../test_helper'

class OperatingSystemTest < Minitest::Test

    def test_screen_resolution_has_many_payloads
      os = OperatingSystem.new
      assert_equal [], os.payloads
    end

end
