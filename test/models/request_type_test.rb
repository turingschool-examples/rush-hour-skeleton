require_relative "../test_helper"

class RequestTypeTest < Minitest::Test
  include TestHelper

  def test_it_can_save_request_type
    RequestType.create(verb: "GET")

    request_type = RequestType.first

    assert_equal "GET", request_type.verb
  end

  def test_it_doesnt_save_request_type_with_invalid_verb
    RequestType.create()

    assert_equal [], RequestType.all.to_a
  end

  def test_it_returns_the_most_frequent_request_type
    request_1 = RequestType.create(verb: "GET")
    request_2 = RequestType.create(verb: "POST")

    create_payload_requests(request_1.id, request_2.id)
    create_client

    expected = {"GET" => 2, "POST" => 1}

    assert_equal expected, Client.find(1).request_types.most_frequent
  end

  def test_it_returns_all_verbs_requested
    RequestType.create(verb: "GET")
    RequestType.create(verb: "POST")

    assert RequestType.all_verbs_used.include?("POST")
    assert RequestType.all_verbs_used.include?("GET")
  end

  def test_it_has_many_payload_requests
    request = RequestType.create(verb: "GET")

    create_generic_payload_requests

    assert_equal 2, request.payload_requests.count
  end

  def create_payload_requests(request_id1, request_id2)

    PayloadRequest.create(
      url_id:          1,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   100,
      referral_id:     1,
      request_type_id: request_id1,
      event_id:        1,
      user_agent_id:   1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)

    PayloadRequest.create(
      url_id:          1,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   200,
      referral_id:     1,
      request_type_id: request_id1,
      event_id:        1,
      user_agent_id:   1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)

    PayloadRequest.create(
      url_id:          1,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   200,
      referral_id:     1,
      request_type_id: request_id2,
      event_id:        1,
      user_agent_id:   1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)
  end
end
