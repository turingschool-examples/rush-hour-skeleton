require_relative "../test_helper"

class RequestTypeTest < Minitest::Test
  include TestHelper

  def test_it_can_save_request_type
    RequestType.create(verb: "GET")

    request_type = RequestType.first

    assert_equal "GET", request_type.verb
  end

  def test_it_doesnt_save_request_type_with_invalid_verb
    RequestType.create()

    assert_equal [], RequestType.all.to_a
  end
end
