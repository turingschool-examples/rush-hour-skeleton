require './test/test_helper'

class RequestTypeTest < ModelTest
  def test_create_request_type_with_valid_parameters
    payload_data = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
      }

    request_type = TrafficSpy::RequestType.find_or_create_by(verb: payload_data[:request_type_string])
    assert_equal 1, TrafficSpy::RequestType.count
    assert_equal "GET", request_type.verb
  end
end
