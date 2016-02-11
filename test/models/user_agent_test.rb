require_relative '../test_helper'

class UserAgentTest < Minitest::Test
  include TestHelpers

  def test_user_agent_can_instantiate_with_browser_and_platform
    ua = UserAgent.new(browser: "Chrome", platform: "Macintosh")
    assert ua.valid?
  end

  def test_user_agent_needs_browser_and_platform_to_instantiate
    ua = UserAgent.new()
    refute ua.valid?
    ua = UserAgent.new(browser: "Chrome")
    refute ua.valid?
    ua = UserAgent.new(platform: "Macintosh")
    refute ua.valid?
  end

  def test_user_agent_has_a_browser_and_platform
    ua = UserAgent.create(browser: "Chrome", platform: "Macintosh")
    assert_equal "Chrome", ua.browser
    assert_equal "Macintosh", ua.platform
  end

  def test_user_agent_has_payload_requests
    ua = UserAgent.new(browser: "Chrome", platform: "Macintosh")
    assert_respond_to ua, :payload_requests
  end

end
