require './test/test_helper'

class ResolutionTest < ModelTest
  def test_create_resolution_with_valid_parameters
    payload_data = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
      }

    resolution = TrafficSpy::Resolution.find_or_create_by(width: payload_data[:resolution_string][:width],
                                                          height: payload_data[:resolution_string][:height])
    assert_equal 1, TrafficSpy::Resolution.count
    assert_equal 1920, resolution.width
    assert_equal 1280, resolution.height
  end

  def test_create_same_resolution_with_valid_parameters_only_once
    payload_data = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
      }

    TrafficSpy::Resolution.find_or_create_by(width: payload_data[:resolution_string][:width],
                                             height: payload_data[:resolution_string][:height])
    TrafficSpy::Resolution.find_or_create_by(width: payload_data[:resolution_string][:width],
                                             height: payload_data[:resolution_string][:height])
    assert_equal 1, TrafficSpy::Resolution.count
  end
end
