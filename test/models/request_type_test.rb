require_relative "../test_helper"

class RequestTypeTest < Minitest::Test

  def test_it_has_relationship_with_payload_request
    r = RequestType.new
    assert_respond_to(r, :payload_requests)
  end
end
