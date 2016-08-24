require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelpers

  def test_can_be_created_with_width_and_height
    data = { width: "1920", height: "1080" }
    res = Resolution.create(data)
    assert_equal "1920", res.width
    assert_equal "1080", res.height
    assert res.valid?
  end

  def test_is_invalid_with_missing_width
    data = { width: "1920", height: nil }
    res = Resolution.create(data)
    assert res.height.nil?
    refute res.valid?
  end

  def test_is_invalid_with_missing_height
    data = { width: nil, height: "1080" }
    res = Resolution.create(data)
    assert res.width.nil?
    refute res.valid?
  end

end
