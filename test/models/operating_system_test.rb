require './test/test_helper'

class OperatingSystemTest < ModelTest
  def test_create_operating_system_with_valid_parameters
    payload_data = {
      relative_path: "/blog",
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

    operating_system = TrafficSpy::OperatingSystem.find_or_create_by(op_system: payload_data[:operating_system_string])
    assert_equal 1, TrafficSpy::OperatingSystem.count
    assert_equal "/blog", operating_system.op_system
  end
end
