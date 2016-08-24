require_relative '../test_helper'
require './app/models/user_agent'

class UserAgentTest < Minitest::Test
  def test_it_validates_input
    user_agent = UserAgent.new({browser: "Do T Browser",
                                operating_system: "Do T OSX"})

    user_agent_sad = UserAgent.new({browser: "Sad Do T Browser"})
    assert user_agent.save
    refute user_agent_sad.save
  end
end