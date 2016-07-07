require_relative '../test_helper'
require 'pry'

class SoftwareAgentTest < Minitest::Test
 include TestHelpers

 def test_it_creates_user_agent
   user_agent = create_software_agent

   assert user_agent.valid?

   assert_equal "OS X 10.8.2", software_agent.os
   assert_equal "Chrome", software_agent.browser
 end

end
