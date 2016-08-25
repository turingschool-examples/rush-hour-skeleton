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

  def test_it_only_adds_unique_data
    data = { name: "GET" }

    assert_equal 0, RequestType.count

    rt_1 = RequestType.create(data)

    assert_equal 1, RequestType.count
    assert rt_1.valid?

    rt_2 = RequestType.create(data)

    assert_equal 1, RequestType.count
    refute rt_2.valid?
  end
end
