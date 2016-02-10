require_relative '../test_helper'

class UserEnvironmentTest < Minitest::Test
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
end
