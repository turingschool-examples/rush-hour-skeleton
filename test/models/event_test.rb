require './test/test_helper'

class EventTest < ModelTest
  def test_create_event_with_valid_parameters
    payload_data = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
      }

    event = TrafficSpy::Event.find_or_create_by(event_name: payload_data[:event_string])
    assert_equal 1, TrafficSpy::Event.count
    assert_equal "socialLogin", event.event_name
  end
end
