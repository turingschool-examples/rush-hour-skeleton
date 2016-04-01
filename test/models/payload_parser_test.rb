require_relative '../test_helper'
require_relative '../../app/models/payload_parser'

class PayloadParserTest < Minitest::Test
	include Rack::Test::Methods
  include TestHelpers
	include PayloadParser

	def test_can_check_if_client_is_registered
		register_client

		assert client_exists?("jumpstartlab")
		refute client_exists?("not a client")
	end

	def test_can_check_if_payload_is_valid
		params = get_params

		assert payload_valid?(params)
	end

	def test_can_check_if_payload_already_exists

	end
end
