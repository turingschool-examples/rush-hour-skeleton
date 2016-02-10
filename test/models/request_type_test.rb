require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
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
end
