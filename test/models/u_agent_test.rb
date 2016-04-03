require_relative '../test_helper'

class UAgentTest < Minitest::Test
  include TestHelpers

  def test_it_can_accept_u_agent
    u_agent = UAgent.create(browser: "Mozilla/5.0 (Macintosh; Intel)")

    assert_equal "Mozilla/5.0 (Macintosh; Intel)", u_agent.browser
  end

  def test_it_checks_for_empty_browser
    u_agent = UAgent.create(browser: nil)

    assert_nil u_agent.browser
  end

  def test_it_responds_with_an_error_message
    u_agent = UAgent.create(browser: nil)

    assert_equal "can't be blank", u_agent.errors.messages[:browser][0]
  end

  def test_browser_breakdown_across_all_requests
    setup_data

    assert_equal ["Mozilla", "Chrome", "Safari"], UAgent.browser_breakdown_across_all_requests
  end

  def test_platform_breakdown_across_all_requests
    setup_data

    assert_equal ["Windows", "Webkit", "Macintosh"], UAgent.platform_breakdown_across_all_requests
  end
end
