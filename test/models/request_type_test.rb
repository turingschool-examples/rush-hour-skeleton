require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def test_that_it_creates_a_request_type_row
    rt = RequestType.new(verb: "GET" )
    assert rt.valid?
  end

  def test_that_it_does_not_get_created_with_no_info
    rt = RequestType.new(verb: nil)
    refute rt.valid?
  end

  def test_that_it_has_a_relationship_with_payload_request
    pr = PayloadRequest.create(requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: 1, referral_id: 1, request_type_id: 1, user_agent_device_id: 1, resolution_id: 1, ip_id: 1)

    assert pr.respond_to?(:request_type)
  end

  def test_that_calculates_most_frequent_request_types

  end
end
