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

  def test_it_returns_the_most_frequent_request_type
    RequestType.create(verb: "GET")
    RequestType.create(verb: "POST")
    RequestType.create(verb: "GET")

    assert_equal "GET", RequestType.most_frequent
  end

  def test_it_returns_all_verbs_requested
    RequestType.create(verb: "GET")
    RequestType.create(verb: "POST")
    RequestType.create(verb: "GET")

    assert RequestType.all_verbs_used.include?("POST")
    assert RequestType.all_verbs_used.include?("GET")
  end
end
