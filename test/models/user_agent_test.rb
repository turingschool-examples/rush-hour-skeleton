require_relative '../test_helper'
require './app/models/user_agent'

class UserAgentTest < ModelTest
  def test_it_validates_input
    user_agent = UserAgent.new({browser: "Do T Browser",
                                operating_system: "Do T OSX"})

    user_agent_sad = UserAgent.new({browser: "Sad Do T Browser"})
    assert user_agent.save
    refute user_agent_sad.save
  end

    def test_browser_needs_unique_operating_system
      user_agent = UserAgent.create({browser: "Do T Browser",
                                  operating_system: "Do T OSX"})
      user_agent = UserAgent.new({browser: "Do T Browser",
                                  operating_system: "New OSX"})
      assert user_agent.save
    end

    def test_operating_system_needs_unique_browser
      user_agent = UserAgent.create({browser: "Do T Browser",
                                  operating_system: "Do T OSX"})
      user_agent = UserAgent.new({browser: "Browser",
                                  operating_system: "Do T OSX"})
      assert user_agent.save
    end

    def test_combination_of_operating_system_and_browser_is_unique
      user_agent = UserAgent.create({browser: "Do T Browser",
                                  operating_system: "Do T OSX"})
      user_agent = UserAgent.new({browser: "Do T Browser",
                                  operating_system: "Do T OSX"})
      refute user_agent.save
    end


  end
