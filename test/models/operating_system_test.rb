require_relative '../test_helper'

class OperatingSystemTest < Minitest::Test

    def test_operating_systems_has_many_payloads
      os = OperatingSystem.new
      assert_equal [], os.payloads
    end

end
