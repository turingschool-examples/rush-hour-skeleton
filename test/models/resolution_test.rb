require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelpers

  def test_resolution_can_instantiate_with_height_and_width
    res = Resolution.new(height: "1920", width: "1280")
    assert res.valid?
  end

  def test_resolution_needs_height_and_width_to_instantiate
    res = Resolution.new()
    refute res.valid?
    res = Resolution.new(height: "1920")
    refute res.valid?
    res = Resolution.new(width: "1280")
    refute res.valid?
  end

  def test_resolution_has_a_height_and_width
    res = Resolution.create(height: "1920", width: "1280")
    assert_equal "1280", res.width
    assert_equal "1920", res.height
  end

  def test_resolution_has_payload_requests
    res = Resolution.new(height: "1920", width: "1280")
    assert_respond_to res, :payload_requests
  end

end
