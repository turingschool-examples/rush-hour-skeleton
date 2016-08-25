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

    def test_it_can_show_all_browsers
      user_agent1 = UserAgent.create({browser: "Chrome", operating_system: "Windows"})
      user_agent2 = UserAgent.create({browser: "Internet Explorer", operating_system: "Windows"})
      user_agent3 = UserAgent.create({browser: "Internet Explorer", operating_system: "Windows"})
      user_agent4 = UserAgent.create({browser: "Chrome", operating_system: "iOS"})
      user_agent4 = UserAgent.create({browser: "Chrome", operating_system: "iOS"})

      assert_equal ["Chrome", "Internet Explorer", "Chrome"], UserAgent.get_all_browsers
    end

    def test_it_can_show_all_operating_systems
      user_agent1 = UserAgent.create({browser: "Chrome", operating_system: "Windows"})
      user_agent2 = UserAgent.create({browser: "Internet Explorer", operating_system: "Windows"})
      user_agent3 = UserAgent.create({browser: "Internet Explorer", operating_system: "Windows"})
      user_agent4 = UserAgent.create({browser: "Chrome", operating_system: "iOS"})
      user_agent4 = UserAgent.create({browser: "Chrome", operating_system: "iOS"})

      assert_equal ["Windows", "Windows", "iOS"], UserAgent.get_all_operating_systems
    end

  end
