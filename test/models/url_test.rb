require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def setup
    PayloadRequest.find_or_create_by({url: Url.find_or_create_by(root: "http://jumpstartlab.com", path: "/blog"),
                           requested_at: "2014-02-16 21:38:28 -0700",
                           responded_in: 0,
                           referral: Referral.find_or_create_by(name: "http://jumpstartlab.com"),
                           request_type: RequestType.find_or_create_by(verb: "GET"),
                           user_agent_device: UserAgentDevice.find_or_create_by(os: "Chrome", browser: "Macintosh"),
                           resolution: Resolution.find_or_create_by(height: "1280", width: "1920"),
                           ip: Ip.find_or_create_by(ip_address: "33.33.33.333"),
                           sha: Digest::SHA256.digest("data_one")
                           })
    PayloadRequest.find_or_create_by({url: Url.find_or_create_by(root: "http://jumpstartlab.com", path: "/blog"),
                           requested_at: "2015-02-16 21:38:28 -0700",
                           responded_in: 50,
                           referral: Referral.find_or_create_by(name: "http://layofflab.com"),
                           request_type: RequestType.find_or_create_by(verb: "PUT"),
                           user_agent_device: UserAgentDevice.find_or_create_by(os: "Safari", browser: "Mac"),
                           resolution: Resolution.find_or_create_by(height: "1000", width: "2000"),
                           ip: Ip.find_or_create_by(ip_address: "22.22.22.222"),
                           sha: Digest::SHA256.digest("data_two")
                           })
    PayloadRequest.find_or_create_by({url: Url.find_or_create_by(root: "http://jumpstartlab.com", path: "/blog"),
                           requested_at: "2016-02-16 21:38:28 -0700",
                           responded_in: 100,
                           referral: Referral.find_or_create_by(name: "http://turing.io"),
                           request_type: RequestType.find_or_create_by(verb: "POST"),
                           user_agent_device: UserAgentDevice.find_or_create_by(os: "Firefox", browser: "Mac_daddy"),
                           resolution: Resolution.find_or_create_by(height: "900", width: "900"),
                           ip: Ip.find_or_create_by(ip_address: "66.66.66.666"),
                           sha: Digest::SHA256.digest("data_three")
                           })
                          #  require "pry"; binding.pry
  end

  def test_that_it_creates_a_url_row
    url = Url.new(root: "www.google.com", path: "/students")
    assert url.valid?
    assert url.root?
    assert url.path?
  end

  def test_it_does_not_get_created_without_browser_info
    url = Url.new(root: nil, path: "/blog")
    refute url.valid?
    refute url.root?
    assert url.path?
  end

  def test_it_does_not_get_created_without_browser_info
    url = Url.new(root: "www.google.com", path: nil)
    refute url.valid?
    refute url.path?
    assert url.root?
  end

  def test_it_has_a_relationship_with_payload_requests
    url = Url.new
    assert url.respond_to?(:payload_requests)
    assert url.respond_to?(:request_types)
    assert url.respond_to?(:referrals)
    assert url.respond_to?(:requested_at)
    assert url.respond_to?(:user_agent_devices)
  end

  def test_the_find_specific_url
    setup

    assert_instance_of Url, Url.find_specific_url("/blog")
  end

  def test_max_response_time_for_url
    setup
    url = Url.find_specific_url("/blog")

    assert_equal 100, url.max_response_time_for_url
  end

  def test_min_response_time_for_url
    setup
    url = Url.find_specific_url("/blog")

    assert_equal 0, url.min_response_time_for_url
  end

  def test_response_time_list_for_url
    setup
    url = Url.find_specific_url("/blog")

    assert_equal [0, 50, 100], url.response_time_list_for_url
  end

  def test_average_response_time_for_url
    setup
    url = Url.find_specific_url("/blog")

    assert_equal 50, url.average_response_time_for_url
  end

  def test_finds_verbs_associated_with_url
    setup
    url = Url.find_specific_url("/blog")

    assert_equal ["GET", "PUT", "POST"], url.verb_list_for_url
  end

  def test_top_referrers_for_url
    setup
    url = Url.find_specific_url("/blog")

    expected = ["http://jumpstartlab.com", "http://layofflab.com", "http://turing.io"]
    assert_equal expected, url.top_referrers_for_url
  end

  def test_top_user_agents_for_url
    setup
    url = Url.find_specific_url("/blog")

    expected = [["Macintosh", "Chrome"], ["Mac", "Safari"], ["Mac_daddy", "Firefox"]]
    assert_equal expected, url.top_user_agents_for_url
  end
end
