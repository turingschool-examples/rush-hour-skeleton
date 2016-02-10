require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def test_responds_to_payloads
    e = RequestType.create(verb: "GET")

    assert e.respond_to? :payloads
  end

  def test_brings_in_correct_data
    e = RequestType.create(verb: "GET")

    assert_equal "GET", e.verb
  end

  def test_wont_validate_incorrect_data
    e = RequestType.create
    assert_nil e.id

    d = RequestType.new verb: nil
    assert_nil d.verb
  end

  def test_return_most_frequent_request_type
    setup_1
    assert_equal "GET", RequestType.most_frequent_request_type

  end

  def test_returns_list_of_all_verbs_used_ever
    setup_1
    assert_equal "POST, GET", RequestType.returns_list_verbs
  end
end
