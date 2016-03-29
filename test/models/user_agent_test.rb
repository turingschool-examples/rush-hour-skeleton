require_relative '../test_helper'

class UserAgentTest < Minitest::Test
  include TestHelper

  def test_it_can_save_user_agent
    UserAgent.create(browser: "Mozilla/5.0",
                          os: "Macintosh; Intel Mac OS X 10_8_2")

    user_agent = UserAgent.first

    assert_equal "Mozilla/5.0", user_agent.browser
    assert_equal "Macintosh; Intel Mac OS X 10_8_2", user_agent.os
  end

  def test_it_doesnt_save_user_agent_with_invalid_browser
    UserAgent.create(os: "Macintosh; Intel Mac OS X 10_8_2")

    assert_equal [], UserAgent.all.to_a
  end

  def test_it_doesnt_save_user_agent_with_invalid_os
    UserAgent.create(browser: "Mozilla/5.0")

    assert_equal [], UserAgent.all.to_a
  end
end
