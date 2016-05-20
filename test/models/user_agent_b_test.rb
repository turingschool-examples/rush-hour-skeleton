require_relative "../test_helper"

class UserAgentBTest < Minitest::Test
  include TestHelpers

  def setup
    UserAgentB.create({:browser => "Chrome", :platform => "Macintosh"})
    UserAgentB.create({:browser => "Firefox", :platform => "Windows"})
    UserAgentB.create({:browser => "Firefox", :platform => "Windows"})
  end

  def test_breakdown_browsers
    browser = UserAgentB.web_browser_breakdown

    assert_equal ["Chrome", "Firefox"], browser
  end

  def test_breakdown_platform
    os = UserAgentB.os_breakdown

    assert_equal ["Macintosh", "Windows"], os
  end

end
