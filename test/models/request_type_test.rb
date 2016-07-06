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

end
