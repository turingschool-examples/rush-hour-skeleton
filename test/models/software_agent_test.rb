require_relative '../test_helper'

class SoftwareAgentTest < Minitest::Test
 include TestHelpers

 def test_it_creates_user_agent
   user_agent = create_software_agent
   assert user_agent.valid?

   assert_equal "OS X 10.8.2", software_agent.os
   assert_equal "Chrome", software_agent.browser
 end

  def test_browser_breakdown_returns_browser_with_count
    create_payload(2)
    assert_equal ["Chrome0"], SoftwareAgent.web_browser_breakdown
  end

  def test_platform_breakdown_returns_platform_with_count
    create_payload(2)
    assert_equal ["OSX 10.11.50"], SoftwareAgent.web_platform_breakdown
  end
end
