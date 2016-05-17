require_relative "../test_helper"

class RequestTypeTest < Minitest::Test
  def test_validations_work
    request = RequestType.create({
        request_type: "Lucy's BADDDDDD boys"
      })
    assert request.valid?
  end

  def test_empty_string_is_invalid
    request = RequestType.create({
        request_type: ""
      })
    assert request.invalid?
  end

  def test_nil_is_invalid
    request = RequestType.create({
        request_type: nil
      })
    assert request.invalid?
  end

  def test_no_info_is_invalid
    request = RequestType.create
    assert request.invalid?
  end

  def test_it_has_relationship_with_payload_request
    r = RequestType.new
    assert_respond_to(r, :payload_requests)
  end
end
