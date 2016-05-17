require_relative "../test_helper"

class ReferredByTest < Minitest::Test

  def test_it_has_relationship_with_payload_request
    r = ReferredBy.new
    assert_respond_to(r, :payload_requests)
  end
end
