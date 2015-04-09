require './test/test_helper'

# module TrafficSpy
  class UserAgentTest < Minitest::Test

    def test_user_agent_can_be_added_to_table
      TrafficSpy::UserAgent.create(browser: "Chrome", version: "10", platform: "Mac")

      user_agent = TrafficSpy::UserAgent.last
      assert_equal "Chrome", user_agent.browser
      assert_equal "10", user_agent.version
      assert_equal "Mac", user_agent.platform
    end
  end
# end