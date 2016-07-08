require_relative '../test_helper'

class UserAgentDeviceTest < Minitest::Test
  include TestHelpers

  def test_that_it_creates_a_user_agent_row_with_all_required_data
    ua = UserAgentDevice.new(browser: "Chrome", os: "Mac OS X 10_8_2")
    assert ua.valid?
  end

  def test_that_it_fails_when_only_browser_info_is_provided
    ua = UserAgentDevice.new(browser: "Chrome")
    refute ua.valid?
    assert ua.invalid?
  end

  def test_that_it_fails_when_only_operating_system_info_is_provided
    ua = UserAgentDevice.new(os: "Mac OS X 10_8_2")
    refute ua.valid?
    assert ua.invalid?
  end

  def test_there_is_a_relationship_with_payload_requests_and_user_agent
    pr = PayloadRequest.new(requested_at: "2013-02-16 21:38:28 -0700",
    responded_in: 37, url_id: 1, referral_id: 1, request_type_id: 1,
    user_agent_device_id: 1, resolution_id: 1, ip_id: 1)
    ua = UserAgentDevice.new(browser: "Mozilla/5.0", os: "Mac OS X 10_8_2")

    assert pr.respond_to?(:user_agent_device_id)
  end

  def test_it_can_parse_agent_device_into_from_user_agent
    string = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.56 Safari/536.5'
    user_agent = UserAgent.parse(string)
    assert_equal "Chrome", user_agent.browser
    assert_equal "Macintosh", user_agent.platform
    assert_equal "19.0.1084.56", user_agent.version
  end

  def test_it_can_parse_browser_and_platform_os_from_user_agent
    user_agent = UserAgent.parse(parsed_payload["userAgent"])
    assert_equal "Chrome", user_agent.browser
    assert_equal "Macintosh", user_agent.platform
  end

  def test_it_can_breakdown_browser_information

  end

end
