require_relative '../test_helper'

class UserAgentTest < Minitest::Test
  include TestHelpers

  def test_it_can_be_created_with_os_and_browser
    data = { browser: "Chrome",
             os: "MacOSX" }

    ua = UAgent.create(data)

    assert_equal "Chrome", ua.browser
    assert_equal "MacOSX", ua.os
    assert ua.valid?
  end

  def test_it_does_not_create_when_browser_is_nil
    data = { browser: nil,
             os: "MacOSX" }

    ua = UAgent.create(data)

    assert_equal nil, ua.browser
    assert_equal "MacOSX", ua.os
    refute ua.valid?
  end

  def test_it_does_not_create_when_os_is_nil
    data = { browser: "Chrome",
             os: nil }

    ua = UAgent.create(data)

    assert_equal "Chrome", ua.browser
    assert_equal nil, ua.os
    refute ua.valid?
  end

  def test_it_only_adds_unique_data
    data_1 = { browser: "Chrome",  os: "MacOSX" }
    data_2 = { browser: "Chrome",  os: "Linux" }
    data_3 = { browser: "Firefox", os: "Linux" }

    assert_equal 0, UAgent.count

    ua_1 = UAgent.create(data_1)
    ua_2 = UAgent.create(data_2)
    ua_3 = UAgent.create(data_3)

    assert_equal 3, UAgent.count
    assert ua_1.valid? && ua_2.valid? && ua_3.valid?

    ua_4 = UAgent.create(data_1)

    assert_equal 3, UAgent.count
    refute ua_4.valid?
  end
end
