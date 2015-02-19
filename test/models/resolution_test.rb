require './test/test_helper'

class ResolutionTest < Minitest::Test

	def setup
		DatabaseCleaner.clean
	end
	def teardown
		DatabaseCleaner.clean
	end

	def test_it_is_valid_with_both_resolution_values
			resolution = Resolution.new({ 'resolutionWidth'  => '1920',
	    													 	  'resolutionHeight' => "1280" })
			assert resolution.valid?
	end


end