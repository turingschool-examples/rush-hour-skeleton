require_relative '../test_helper'

class UserAgentTest < Minitest::Test
  include TestHelpers

  def test_it_can_be_created_with_os_and_browser
    data = { browser: "Chrome",
             os: "MacOSX" }

    ua = RushHour::UserAgent.create(data)

    assert_equal "Chrome", ua.browser
    assert_equal "MacOSX", ua.os
    assert ua.valid?
  end

  def test_it_does_not_create_when_browser_is_nil
    data = { browser: nil,
             os: "MacOSX" }

    ua = RushHour::UserAgent.create(data)

    assert_equal nil, ua.browser
    assert_equal "MacOSX", ua.os
    refute ua.valid?
  end

  def test_it_does_not_create_when_os_is_nil
    data = { browser: "Chrome",
             os: nil }

    ua = RushHour::UserAgent.create(data)

    assert_equal "Chrome", ua.browser
    assert_equal nil, ua.os
    refute ua.valid?
  end
end
