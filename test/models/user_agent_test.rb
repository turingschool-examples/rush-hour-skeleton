require_relative "../test_helper"

class UserAgentTest < Minitest::Test

  def test_it_has_relationship_with_payload_request
    u = UserAgent.new
    assert_respond_to(u, :payload_requests)
  end
end
