require_relative '../test_helper'

class ResolutionTest < TrafficTest
  include PayloadPrep

  def setup
    setup_model_testing_environment
    @resolution = TrafficSpy::Resolution
  end

  def test_dimension
    expected_result = "1920 x 1280"
    assert_equal expected_result, @resolution.dimension(1)
  end
end
