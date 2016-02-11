require_relative '../test_helper'

class UserEnvironmentTest < Minitest::Test
  include TestHelpers

  def test_responds_to_payloads
    e = UserEnvironment.create(browser: "Chrome", os: "OS")

    assert e.respond_to? :payloads
  end

  def test_brings_in_correct_data
    e = UserEnvironment.create(browser: "Firefox", os: "OS")

    assert_equal "Firefox", e.browser
    assert_equal "OS", e.os
  end

  def test_wont_validate_incorrect_data
    e = UserEnvironment.create
    assert_nil e.id

    d = UserEnvironment.new browser: nil
    assert_nil d.browser
  end

  def test_it_can_show_all_browsers_across_requests
    setup_1
    expected = {"Mozilla"=>1, "Safari"=>1, "Chrome"=>1}
    assert_equal expected, UserEnvironment.browser_breakdown
  end

  def test_it_can_show_all_os_across_requests
    setup_1
    expected = {"doors"=>1, "SOS"=>1, "windows"=>1}
    assert_equal expected, UserEnvironment.os_breakdown
  end
end
