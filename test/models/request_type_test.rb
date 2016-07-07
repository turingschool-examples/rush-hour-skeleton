require_relative '../test_helper'

class RequestTypeTest < Minitest::Test

  def test_it_can_create_request_type
    type = RequestType.create(verb: "GET")
    assert_equal "GET", type.verb
  end
end
