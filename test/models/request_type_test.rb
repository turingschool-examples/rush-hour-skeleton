require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  def test_responds_to_payloads
    e = RequestType.create(requestType: "GET")

    assert e.respond_to? :payloads
  end

  def test_brings_in_correct_data
    e = RequestType.create(requestType: "GET")

    assert_equal "GET", e.requestType
  end

  def test_wont_validate_incorrect_data
    e = RequestType.create
    assert_nil e.id

    d = RequestType.new requestType: nil
    assert_nil d.requestType
  end
end
