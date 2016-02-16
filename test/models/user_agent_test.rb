require_relative '../test_helper'

class UserAgentTest < Minitest::Test
  include TestHelpers

  def test_web_browser_breakdown_across_requests
    create_payloads(4)
    assert_equal ["Chrome 24.0.1309", "AOL 9.7.4343"], UserAgent.browser_breakdown
  end

  def test_os_breakdown_across_requests
    create_payloads(4)
    assert_equal ["Mac OS X 10.8.2", "Windows 7"], UserAgent.os_breakdown
  end

end
