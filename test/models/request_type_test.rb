require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_request_type_instance
    request_type = create_request_type
    verb = "GET"

    assert_equal verb, request_type.verb
  end

  def test_request_type_relationship_to_payload_requests
    create_payload(1)
    request_type = RequestType.first
    request_type.payload_requests << PayloadRequest.all.first

    refute request_type.payload_requests.empty?
    request_type.payload_requests.exists?(request_type.id)
    assert_equal 1, request_type.payload_requests.size
  end

end
