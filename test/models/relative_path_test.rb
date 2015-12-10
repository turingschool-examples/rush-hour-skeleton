require './test/test_helper'

class RelativePathTest < ModelTest
  def test_create_relative_path_with_valid_parameters
    payload_data = {
      relative_path: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
      }

    rel_path = TrafficSpy::RelativePath.find_or_create_by(path: payload_data[:relative_path])
    assert_equal 1, TrafficSpy::RelativePath.count
    assert_equal "/blog", rel_path.path
  end
end
