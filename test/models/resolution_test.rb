require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelpers

  def test_responds_to_payloads
    e = Resolution.create(height: "1280", width: "1920")

    assert e.respond_to? :payloads
  end

  def test_brings_in_correct_data
    e = Resolution.create(height: "1280", width: "1920")

    assert_equal "1920", e.width
    assert_equal "1280", e.height
  end

  def test_wont_validate_incorrect_data
    e = Resolution.create
    assert_nil e.id

    d = Resolution.new height: nil
    assert_nil d.height
  end

  def test_it_can_show_resolution_breakdown
    setup_1
    expected = ["2000 x 2000", "1000 x 1000", "500 x 500"]
    assert_equal expected, Resolution.resolution_breakdown
  end

end
