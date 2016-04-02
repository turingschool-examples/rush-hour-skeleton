require_relative '../test_helper'

class EventTest < Minitest::Test
  include TestHelper

  def test_it_can_save_an_event
    Event.create(name: "socialLogin")

    event = Event.first

    assert_equal "socialLogin", event.name
  end

  def test_it_wont_save_an_invalid_event
    Event.create

    assert_equal [], Event.all.to_a
  end

  def test_it_returns_events_most_recieved_to_least
    event1 = Event.create(name: "socialLogin")
    event2 = Event.create(name: "NOTsocialLogin")

    create_payload_requests(event1.id, event2.id)

    assert Event.most_to_least_requested.include?("socialLogin")
    assert Event.most_to_least_requested.include?("NOTsocialLogin")
  end

  def test_it_has_many_payload_requests
    event = Event.create(name: "socialLogin")

    create_generic_payload_requests

    assert_equal 2, event.payload_requests.count
  end

  def create_payload_requests(event1_id, event2_id)
    PayloadRequest.create(url_id: 1,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 1,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: event1_id,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    PayloadRequest.create(url_id: 2,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 1,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: event2_id,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    PayloadRequest.create(url_id: 1,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 1,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: event1_id,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

  end

end
