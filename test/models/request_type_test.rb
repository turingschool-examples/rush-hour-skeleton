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
   type = RequestType.create(verb: "PUT")
   assert_equal 3, RequestType.count

  end

  def test_sorted_list_of_http_verbs_used_least_greatest
    create_payload2(1)
    create_payload3(3)
    create_payload5(5)
    assert_equal ["PUT", "POST", "GET"], RequestType.sorted_list_of_http_verbs_used
  end
end
