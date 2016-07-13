require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelpers

  def test_it_creates_a_resolution_height_row
    res = Resolution.new(height: "600", width: "800")
    assert res.valid?
  end

  def test_it_does_not_get_created_when_required_info_is_missing
    res = Resolution.new(height: nil, width: nil)
    refute res.valid?
  end

  def test_it_fails_when_only_a_resolution_width_is_provided
    res = Resolution.new(width: "800")
    refute res.valid?
  end

  def test_it_fails_when_only_a_resolution_height_is_provided
    res = Resolution.new(height: "600")
    refute res.valid?
  end

  def test_there_is_a_relationship_with_payload_requests
    res = Resolution.new
    assert res.respond_to?(:payload_requests)
  end

  def test_resolution_height_and_width_combinations_are_unique
    res = Resolution.create(height: "600", width: "800")
    res2 = Resolution.create(height: "600", width: "800")
    res3 = Resolution.create(height: "700", width: "800")

    assert res.valid?
    refute res2.valid?
    assert res3.valid?
    assert_equal 2, Resolution.count
  end

  def test_it_finds_the_resolution
    res = Resolution.create(height: "600", width: "800")
    res = Resolution.create(height: "500", width: "800")
    res = Resolution.create(height: "700", width: "800")

    assert res.width?
    assert res.height?
    assert_equal ["600 x 800", "500 x 800", "700 x 800"], Resolution.resolution
  end
end
