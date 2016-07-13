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

  def test_that_can_breakdown_browser_across_all_requests
    create_multiple_payloads(3)
    ua1 = UserAgentDevice.create(browser: "Mozilla", os: "Macintosh")
    ua2 = UserAgentDevice.create(browser: "Safari", os: "Windows")
    ua3 = UserAgentDevice.create(browser: "Safari", os: "Macintosh")
    PayloadRequest.all[0].update(user_agent_device_id: ua1.id)
    PayloadRequest.all[1].update(user_agent_device_id: ua2.id)
    PayloadRequest.all[2].update(user_agent_device_id: ua3.id)

    expected = {"Chrome0"=>1, "Mozilla"=>1, "Chrome1"=>1, "Chrome2"=>1, "Safari"=>2}
    assert_equal expected, UserAgentDevice.browser_breakdown
  end

  def test_can_breakdown_os_across_all_requests
    create_multiple_payloads(3)
    ua1 = UserAgentDevice.create(browser: "Mozilla", os: "Macintosh")
    ua2 = UserAgentDevice.create(browser: "Safari", os: "Windows")
    ua3 = UserAgentDevice.create(browser: "Mozilla", os: "Linux")
    PayloadRequest.all[0].update(user_agent_device_id: ua1.id)
    PayloadRequest.all[1].update(user_agent_device_id: ua2.id)
    PayloadRequest.all[2].update(user_agent_device_id: ua3.id)

    expected = {"Linux"=>1, "Windows"=>1, "Macintosh"=>4}
    assert_equal expected, UserAgentDevice.os_breakdown
  end
end
