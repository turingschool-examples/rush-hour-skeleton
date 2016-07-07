require_relative '../test_helper.rb'

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def test_request_type_can_hold_a_name
    request_type = RequestType.create(name: "GET")
    assert_equal "GET", request_type.name
    assert request_type.valid?
    request_type = RequestType.create({})
    refute request_type.valid?
  end

  def test_returns_all_request_types
    RequestType.create(name: "GET")
    RequestType.create(name: "POST")
    RequestType.create(name: "GET")
    assert_equal 3, RequestType.all.count
    assert_equal ["GET", "POST"], RequestType.all_request_types
  end

  def test_returns_most_frequent_request_type
    RequestType.create(name: "POST")
    assert_equal "POST", RequestType.most_frequent_request_type
    RequestType.create(name: "GET")
    assert_equal "GET", RequestType.most_frequent_request_type
  end

end
