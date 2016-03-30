require_relative '../test_helper'

class UserAgentTest < Minitest::Test
  include TestHelpers

  def test_it_can_accept_user_agent
    user_agent = UserAgent.create(browser: "Mozilla/5.0 (Macintosh; Intel)")

    assert_equal "Mozilla/5.0 (Macintosh; Intel)", user_agent.browser
  end

  def test_it_checks_for_empty_browser
    user_agent = UserAgent.create(browser: nil)

    assert_nil user_agent.browser
  end

  def test_it_responds_with_an_error_message
    user_agent = UserAgent.create(browser: nil)

    assert_equal "can't be blank", user_agent.errors.messages[:browser][0]
  end

  def test_browser_breakdown_across_all_requests
    setup_data

    assert_equal ["Mozilla", "Chrome", "Safari"], UserAgent.browser_breakdown_across_all_requests
  end


  def test_platform_breakdown_across_all_requests
    setup_data

    assert_equal ["Windows", "Webkit", "Macintosh"], UserAgent.platform_breakdown_across_all_requests
  end
end
