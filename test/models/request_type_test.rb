require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_request_type_instance
    request_type = create_request_type
    verb = "GET"

    assert_equal verb, request_type.verb
  end


end
