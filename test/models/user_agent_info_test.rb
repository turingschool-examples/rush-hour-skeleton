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

  def test_it_returns_false_when_only_os_version_is_entered
    agent = UserAgentInfo.new({ os: "Windows 10" })
    refute agent.save
  end

  def test_it_returns_true_when_all_information_is_entered
    agent = UserAgentInfo.new({ browser: "Browser!", version: "Version!", platform: "Platform!", os: "Windows 10"})
    assert agent.save
  end

  def test_it_gives_list_of_all_browsers
    agent1 = UserAgentInfo.create({ browser: "Chrome!", version: "Version!", platform: "Platform!", os: "Windows 10"})
    agent2 = UserAgentInfo.create({ browser: "Opera!", version: "Version!", platform: "Platform!", os: "Windows 10"})
    agent3 = UserAgentInfo.create({ browser: "Dolphin!", version: "Version!", platform: "Platform!", os: "Windows 10"})
    agent4 = UserAgentInfo.create({ browser: "Netscape!", version: "Version!", platform: "Platform!", os: "Windows 10"})
    assert_equal ["Chrome!", "Dolphin!", "Netscape!", "Opera!"], UserAgentInfo.all_browsers
  end

  def test_it_gives_list_of_all_oses
    agent1 = UserAgentInfo.create({ browser: "Chrome!", version: "Version!", platform: "Linux", os: "Windows 10"})
    agent2 = UserAgentInfo.create({ browser: "Opera!", version: "Version!", platform: "MacIntosh", os: "Mac OS X"})
    agent3 = UserAgentInfo.create({ browser: "Dolphin!", version: "Version!", platform: "Windows", os: "Windows 8.1"})
    agent4 = UserAgentInfo.create({ browser: "Netscape!", version: "Version!", platform: "Platform!", os: "Windows 95"})
    assert_equal ["Mac OS X", "Windows 10", "Windows 8.1", "Windows 95"], UserAgentInfo.all_oses
  end
end
