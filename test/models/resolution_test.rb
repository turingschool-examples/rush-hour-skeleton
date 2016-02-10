require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  def test_responds_to_payloads
    e = Resolution.create(resolutionHeight: "1280", resolutionWidth: "1920")

    assert e.respond_to? :payloads
  end

  def test_brings_in_correct_data
    e = Resolution.create(resolutionHeight: "1280", resolutionWidth: "1920")

    assert_equal "1920", e.resolutionWidth
  end

  def test_wont_validate_incorrect_data
    e = Resolution.create
    assert_nil e.id

    d = Resolution.new resolutionHeight: nil
    assert_nil d.resolutionHeight
  end
end
