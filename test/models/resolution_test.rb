require './test/test_helper'

module TrafficSpy
  class ResolutionTest < Minitest::Test 

    def setup
      DatabaseCleaner.start
      TestData.feature_tests.each do |payload|
        PayloadValidator.validate(payload[0]["payload"], payload[1])
      end
    end

    def test_it_returns_resolutions
      resolution = Resolution.find(1)
      result = resolution.payloads_resolutions
      assert_equal "1280 x 1920", resolution.height_width
    end

    def teardown
      DatabaseCleaner.clean
    end
  end
end