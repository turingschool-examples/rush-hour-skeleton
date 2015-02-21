class ResolutionTest < Minitest::Test

  def test_it_has_correct_attributes
    resolution = Resolution.create(width: "1920", height: "1280")
    assert_equal 1920, resolution.width
    assert_equal 1280, resolution.height
  end

  def test_it_has_payloads
    resolution = Resolution.create(width: "1920", height: "1280")
    assert_equal [], resolution.payloads
  end
end
