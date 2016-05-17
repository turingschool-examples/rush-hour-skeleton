require_relative "../test_helper"

class EventNameTest < Minitest::Test

  def test_it_has_relationship_with_payload_request
    name = EventName.new
    assert_respond_to(name, :payload_requests)
  end
end
