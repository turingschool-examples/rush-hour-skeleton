require './test/test_helper'

class RelativePathTest < ModelTest
  def test_create_relative_path_with_valid_parameters
    payload_data = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event: "socialLogin",
      operating_system_string: "Macintosh",
      browser: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
      }

    rel_path = TrafficSpy::RelativePath.find_or_create_by(path: payload_data[:relative_path_string])
    assert_equal 1, TrafficSpy::RelativePath.count
    assert_equal "/blog", rel_path.path
  end

  def test_request_type
    register_turing_and_send_multiple_payloads

    path = TrafficSpy::RelativePath.find_by(path: '/blog')
    expected = {"GET" => 2, "POST" => 1}

    assert_equal expected, path.verbs
  end


  def test_max_response_time
    register_turing_and_send_multiple_payloads

    path = TrafficSpy::RelativePath.find_by(path: '/blog')
    assert_equal 80, path.max_response_time

    path = TrafficSpy::RelativePath.find_by(path: '/team')
    assert_equal 41, path.max_response_time

    path = TrafficSpy::RelativePath.find_by(path: '/about')
    assert_equal 25, path.max_response_time
  end

  def test_min_response_time
    register_turing_and_send_multiple_payloads

    path = TrafficSpy::RelativePath.find_by(path: '/blog')
    assert_equal 37, path.min_response_time

    path = TrafficSpy::RelativePath.find_by(path: '/team')
    assert_equal 40, path.min_response_time

    path = TrafficSpy::RelativePath.find_by(path: '/about')
    assert_equal 25, path.min_response_time
  end

  def test_avg_response_time
    register_turing_and_send_multiple_payloads

    path = TrafficSpy::RelativePath.find_by(path: '/blog')
    assert_equal 55.67, path.avg_response_time

    path = TrafficSpy::RelativePath.find_by(path: '/team')
    assert_equal 40.5, path.avg_response_time

    path = TrafficSpy::RelativePath.find_by(path: '/about')
    assert_equal 25, path.avg_response_time
  end

  def test_top_3_referrers
    register_turing_and_send_multiple_payloads

    path = TrafficSpy::RelativePath.find_by(path: '/blog')

    expected = [["http://turing.io", 2], ["http://facebook.com", 1]]

    assert_equal expected, path.top_3_referrers
  end

  def test_top_3_browsers
    register_turing_and_send_multiple_payloads

    path = TrafficSpy::RelativePath.find_by(path: '/blog')

    expected = [["Chrome", 1], ["IE10", 1], ["Safari", 1]]

    assert_equal expected, path.top_3_browsers
  end

  def test_top_3_operating_systems
    register_turing_and_send_multiple_payloads

    path = TrafficSpy::RelativePath.find_by(path: '/blog')

    expected = [["Macintosh", 2], ["Windows", 1]]

    assert_equal expected, path.top_3_operating_systems
  end
end
