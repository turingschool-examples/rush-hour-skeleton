require_relative '../test_helper'

class UserAgentTest < Minitest::Test
  include TestHelper

  def test_it_can_save_user_agent
    UserAgent.create(browser: "Chrome 24.0.1309",
                          os: "Mac OS X 10.8.2")

    user_agent = UserAgent.first

    assert_equal "Chrome 24.0.1309", user_agent.browser
    assert_equal "Mac OS X 10.8.2", user_agent.os
  end

  def test_it_doesnt_save_user_agent_with_invalid_browser
    UserAgent.create(os: "Mac OS X 10.8.2")

    assert_equal [], UserAgent.all.to_a
  end

  def test_it_doesnt_save_user_agent_with_invalid_os
    UserAgent.create(browser: "Chrome 24.0.1309")

    assert_equal [], UserAgent.all.to_a
  end

  def test_it_returns_web_browsers
    UserAgent.create(browser: "Chrome 24.0.1309",
                          os: "Mac OS X 10.8.2")
    UserAgent.create(browser: "IE 9.0",
                          os: "Mac OS X 10.8.2")

    assert_equal ["IE 9.0", "Chrome 24.0.1309"], UserAgent.all_web_browsers
  end

  def test_it_returns_operating_systems
    UserAgent.create(browser: "Chrome 24.0.1309",
                          os: "Mac OS X 10.8.2")
    UserAgent.create(browser: "IE 9.0",
                          os: "Mac OS X 10.8.2")

    assert_equal ["Mac OS X 10.8.2"], UserAgent.all_operating_systems                      
  end

end
