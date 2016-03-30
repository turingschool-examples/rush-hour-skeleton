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

    PayloadRequest.create(url_id: 1,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 1,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: event1.id,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    PayloadRequest.create(url_id: 2,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 1,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: event2.id,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    PayloadRequest.create(url_id: 1,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 1,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: event1.id,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    assert Event.most_to_least_requested.include?("socialLogin")
    assert Event.most_to_least_requested.include?("NOTsocialLogin")

  end

end
