require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_request_type
    type = RequestType.create(verb: "GET")
    assert_equal "GET", type.verb
  end

  def test_most_common_type_of_request
    RequestType.create(verb: "GET")
    RequestType.create(verb: "GET")
    RequestType.create(verb: "GET")
    RequestType.create(verb: "POST")
    assert_equal "GET", RequestType.most_frequent_type
  end

  def test_list_of_http_verbs_used
    RequestType.create(verb: "GET")
    RequestType.create(verb: "GET")
    RequestType.create(verb: "GET")
    RequestType.create(verb: "POST")
    assert_equal ["GET", "GET", "GET", "POST"], RequestType.pluck(:verb)
  end

end
