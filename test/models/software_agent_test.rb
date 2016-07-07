require_relative '../test_helper'

class SoftwareAgentTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_software_agent_instance
    software_agent = create_software_agent
    address = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17"

    assert_equal "Chrome", software_agent.browser
    assert_equal "24.0.1309.0", software_agent.version
    assert_equal "Macintosh", software_agent.platform
  end

end
