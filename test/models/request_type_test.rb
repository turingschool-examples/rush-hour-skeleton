require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_request_type
    type = RequestType.create(verb: "GET")
    assert_equal "GET", type.verb
  end

  def test_uniqueness
   type = RequestType.create(verb: "GET")
   type = RequestType.create(verb: "POST")
   type = RequestType.create(verb: "PUT")

  end

end
