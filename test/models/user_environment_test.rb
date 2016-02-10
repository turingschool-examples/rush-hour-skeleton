require_relative '../test_helper'

class UserEnvironmentTest < Minitest::Test
  def test_responds_to_payloads
    e = UserEnvironment.create(userAgent: "Chrome")

    assert e.respond_to? :payloads
  end

  def test_brings_in_correct_data
    e = UserEnvironment.create(userAgent: "Firefox")

    assert_equal "Firefox", e.userAgent
  end

  def test_wont_validate_incorrect_data
    e = UserEnvironment.create
    assert_nil e.id

    d = UserEnvironment.new userAgent: nil
    assert_nil d.userAgent
  end
end
