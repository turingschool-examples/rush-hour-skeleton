require_relative "../test_helper"

class UserAgentBTest < Minitest::Test
  include TestHelpers

  def setup
    @user_agent1 = UserAgentB.create({:browser => "Chrome", :platform => "Macintosh"})
    @user_agent2= UserAgentB.create({:browser => "Firefox", :platform => "Windows"})
    @user_agent3 = UserAgentB.create({:browser => "Firefox", :platform => "Windows"})
    @user_agent4 = UserAgentB.create({:browser => "Firefox", :platform => ""})
  end

  def test_breakdown_browsers
    browser = UserAgentB.web_browser_breakdown

    assert_equal ["Chrome", "Firefox"], browser
  end

  def test_breakdown_platform
    os = UserAgentB.os_breakdown

    assert_equal ["Macintosh", "Windows"], os
  end

  def test_it_validates_new_referrer_with_all_fields
    assert @user_agent1.valid?
  end

  def test_it_does_not_validate_new_referrer_with_missing_fields
    refute @user_agent4.valid?
  end

end
