require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def test_it_creates_a_request_type_row
    rt = RequestType.new(verb: "GET")
    assert rt.valid?
  end

  def test_it_does_not_get_created_without_info
    rt = RequestType.new(verb: nil)
    refute rt.valid?
  end

  def test_it_has_a_relationship_with_payload_request
    rt = RequestType.new
    assert rt.respond_to?(:payload_requests)
  end

  def test_it_can_list_all_verbs_used
    create_multiple_payloads(3)
    assert_equal ["GET"], RequestType.verb_list
  end
end
