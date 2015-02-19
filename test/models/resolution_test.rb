require './test/test_helper'

class ResolutionTest < Minitest::Test

	def setup
		DatabaseCleaner.clean
	end
	def teardown
		DatabaseCleaner.clean
	end

	def create_four_resolutions
		Resolution.create({ 'resolutionWidth'  => '1920',
	    									'resolutionHeight' => "1280" })

		Resolution.create({ 'resolutionWidth'  => '1980',
	    									'resolutionHeight' => "12100" })

		Resolution.create({ 'resolutionWidth'  => '720',
	    									'resolutionHeight' => "1080" })

		Resolution.create({ 'resolutionWidth'  => '1924',
	    									'resolutionHeight' => "9999" })
	end

	def test_it_is_a_valid_creation_with_both_resolution_values
			resolution = Resolution.create({ 'resolutionWidth'  => '1920',
	    													 	  'resolutionHeight' => "1280" })
			assert resolution.valid?
			assert_equal 1, Resolution.count
	end

	def test_it_is_invalid_when_missing_one_value
		create_four_resolutions
		assert_equal 4,  Resolution.count

		resolution1 = resolution = Resolution.create({ 'resolutionWidth'  => '1920'})
		assert_equal 4, Resolution.count
		refute resolution1.valid?

		resolution2 = resolution = Resolution.create({ 'resolutionHeight' => "1280" })
		assert_equal 4, Resolution.count
		refute resolution2.valid?
	end

	def test_it_is_only_invalid_when_both_values_are_not_unique
		create_four_resolutions
		assert_equal 4, Resolution.count

		resolution_width_height = Resolution.create({ 'resolutionWidth' => "720",
																 						   'resolutionHeight' => "1080"})
		resolution_width = Resolution.create({ 'resolutionWidth' => "920", 
																			  	 'resolutionHeight' => "1080"})
		resolution_height = Resolution.create({ 'resolutionWidth' => "720", 
																			   	  'resolutionHeight' => "1280"})

		refute resolution_width_height.valid?
		assert resolution_width.valid?
		assert resolution_height.valid?

		assert_equal 6, Resolution.count
		assert_equal "720", Resolution.last.resolutionWidth
		assert_equal "1280", Resolution.last.resolutionHeight
	end
end

