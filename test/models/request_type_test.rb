require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def test_it_validates_request_type
    request_type = RequestType.create(verb: "GET")

    assert RequestType.all.first.valid?
    assert_equal 1, RequestType.all.count
  end
end
