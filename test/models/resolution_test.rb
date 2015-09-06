require_relative "../test_helper"

class ResolutionTest < Minitest::Test
  def setup
    DatabaseCleaner.start
  end

  def test_it_has_the_correct_attributes
    assert_equal 0, Resolution.count

    resolution = Resolution.new(resolution_height: "1920", resolution_width: "1280")
    resolution.save

    assert_equal 1, Resolution.count
    assert_equal "1920", Resolution.find(resolution.id).resolution_height
    assert_equal "1280", Resolution.find(resolution.id).resolution_width
  end

  

  def teardown
    DatabaseCleaner.clean
  end
end
