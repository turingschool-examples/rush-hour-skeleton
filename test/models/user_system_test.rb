require_relative '../test_helper'

class UserSystemTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert UserSystem
  end

  # Web browser breakdown across all requests(userSystem)
  def test_list_browser_breakdown_for_all_requests
    create_payload_1
    create_payload_2
    create_payload_3
    expected = ["Firefox", "Safari"]
    assert_equal expected, UserSystem.browser_breakdown.sort
  end

  # OS breakdown across all requests(userSystem)
  def test_os_browser_breakdown_across_all_requests
    create_payload_1
    create_payload_2
    create_payload_3
    expected = ["Mac OSX", "Windows"]
    assert_equal expected, UserSystem.os_breakdown.sort
  end
end
