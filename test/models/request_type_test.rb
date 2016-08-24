require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def test_can_be_created_with_name
    data = { name: "GET" }
    request_type = RequestType.create(data)
    assert_equal "GET", request_type.name
    assert request_type.valid?
  end

  def test_is_invalid_with_missing_request_type
    request_type = RequestType.create({ name: nil })
    assert request_type.name.nil?
    refute request_type.valid?
  end

end
