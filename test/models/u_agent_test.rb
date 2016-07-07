require_relative '../test_helper.rb'

class UAgentTest < Minitest::Test
  include TestHelpers

  def test_it_can_hold_info_on_browser_and_operating_system
    user_agent = UAgent.create(browser: "Chrome", operating_system: "Macintosh")
    assert user_agent.valid?
    assert_equal 'Chrome', user_agent.browser
    assert_equal 'Macintosh', user_agent.operating_system
  end
end
