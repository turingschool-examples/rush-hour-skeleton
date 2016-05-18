require_relative '../test_helper'

class UserAgentInfoTest < Minitest::Test

  include TestHelpers

  def test_it_returns_false_when_only_browser_information_is_entered
    agent = UserAgentInfo.new({ browser: "Browser!" })
    refute agent.save
  end

  def test_it_returns_false_when_only_version_information_is_entered
    agent = UserAgentInfo.new({ version: "Version!" })
    refute agent.save
  end

  def test_it_returns_false_when_only_platform_information_is_entered
    agent = UserAgentInfo.new({ platform: "Platform!" })
    refute agent.save
  end

  def test_it_returns_true_when_all_information_is_entered
    agent = UserAgentInfo.new({ browser: "Browser!", version: "Version!", platform: "Platform!"})
    assert agent.save
  end

end
