require_relative "../test_helper"

class ResolutionTest < Minitest::Test

  def test_it_has_relationship_with_payload_request
    r = Resolution.new
    assert_respond_to(r, :payload_requests)
  end
end
