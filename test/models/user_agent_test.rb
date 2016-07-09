require_relative '../test_helper'

class UserAgentDeviceTest < Minitest::Test
  include TestHelpers

  def test_it_creates_a_user_agent_row_with_all_required_data
    ua = UserAgentDevice.new(browser: "Chrome", os: "Macintosh")
    assert ua.valid?
  end

  def test_it_does_not_get_created_without_info
    ua = UserAgentDevice.new(browser: nil, os: nil)
    refute ua.valid?
  end

  def test_it_fails_when_only_browser_info_is_provided
    ua = UserAgentDevice.new(browser: "Chrome")
    refute ua.valid?
  end

  def test_it_fails_when_only_operating_system_info_is_provided
    ua = UserAgentDevice.new(os: "Macintosh")
    refute ua.valid?
  end

  def test_it_has_a_relationship_with_payload_requests
    ua = UserAgentDevice.new(browser: "Chrome", os: "Macintosh")
    assert ua.respond_to?(:payload_requests)
  end

  def test_that_browser_and_os_combination_is_unique_in_table
    ua = UserAgentDevice.create(browser: "Firefox", os: "Macintosh")
    ua2 = UserAgentDevice.create(browser: "Firefox", os: "Macintosh")

    assert ua.valid?
    refute ua2.valid?
    assert_equal 1, UserAgentDevice.count
  end

end
