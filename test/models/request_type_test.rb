require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def test_it_can_accept_request_type
    verbs = ["GET", "POST", "PUT", "DELETE"]

    verbs.map do |verb|
      request_type = RequestType.create(verb: verb)
      assert_equal verb, request_type.verb
    end
  end

  def test_it_checks_for_empty_address
    request_type = RequestType.create(verb: nil)

    assert_nil request_type.verb
  end

  def test_it_responds_with_an_error_message
    request_type = RequestType.create(verb: nil)

    assert_equal "can't be blank", request_type.errors.messages[:verb][0]
  end
end
