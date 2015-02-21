class RequestTypeTest < Minitest::Test

  def test_it_has_correct_attributes
    request_type = RequestType.create(verb: "GET")
    assert_equal "GET", request_type.verb
  end

  def test_it_has_payloads
    request_type = RequestType.create(verb: "GET")
    assert_equal [], request_type.payloads
  end
end
