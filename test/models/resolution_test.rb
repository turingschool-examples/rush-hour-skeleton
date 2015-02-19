require './test/test_helper'

class ResolutionTest < Minitest::Test

	def setup
		DatabaseCleaner.clean
	end
	def teardown
		DatabaseCleaner.clean
	end

	def test_it_is_a_valid_creation_with_both_resolution_values
			resolution = Resolution.create({ 'resolutionWidth'  => '1920',
	    													 	  'resolutionHeight' => "1280" })
			assert resolution.valid?
			assert_equal 1, Resolution.count
	end

	def test_it_is_invalid_when_missing_one_value
		resolution_true = Resolution.create({ 'resolutionWidth'  => '1920',
	    													 	  'resolutionHeight' => "1280" })
		assert_equal 1,  Resolution.count

		resolution1 = resolution = Resolution.new({ 'resolutionWidth'  => '1920'})
		assert_equal 1, Resolution.count
		refute resolution1.valid?

		resolution2 = resolution = Resolution.new({ 'resolutionHeight' => "1280" })
		assert_equal 1, Resolution.count
		refute resolution2.valid?
	end

end
