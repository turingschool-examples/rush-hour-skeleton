require_relative '../test_helper'

class UserAgentTest < Minitest::Test
  include TestHelpers

  def test_has_attributes
      user_agent = UserAgent.new

      assert_respond_to user_agent, :browser
      assert_respond_to user_agent, :os
  end

  def test_attributes_must_be_present_when_saving
    user_agent = UserAgent.new
    
    refute user_agent.save
    refute_equal 1, UserAgent.all.size
  end

  def test_os_breakdown
    user_agent_1 = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17"
    user_agent_2 = "Mozilla/5.0 (Windows NT 10.0; <64-bit tags>) AppleWebKit/<WebKit Rev> (KHTML, like Gecko) Chrome/<Chrome Rev> Safari/<WebKit Rev> Edge/<EdgeHTML Rev>.<Windows Build>"
    create_payload_requests_with_associations(user_agent: user_agent_1)
    create_payload_requests_with_associations(user_agent: user_agent_2)

    os = UserAgent.os_breakdown

    assert 2, os.count
    assert os.include?("Mac OS X 10.8.2")
    assert os.include?("Windows 10")
  end

  def test_browser_breakdown
    user_agent_1 = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17"
    user_agent_2 = "Mozilla/5.0 (Mobile; ZTEOPEN; rv:18.1) Gecko/18.1 Firefox/18.1"
    create_payload_requests_with_associations(user_agent: user_agent_1)
    create_payload_requests_with_associations(user_agent: user_agent_2)
    create_payload_requests_with_associations(user_agent: user_agent_2)

    browser = UserAgent.browser_breakdown

    assert_equal 2, browser.count
    assert browser.include?("Firefox Mobile")
    assert browser.include?("Chrome")
  end
end
