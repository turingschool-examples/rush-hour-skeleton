require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

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

  def test_it_has_a_relationships_through_payload_requests
    url = Url.new
    assert url.respond_to?(:payload_requests)
    assert url.respond_to?(:request_types)
    assert url.respond_to?(:referrals)
    assert url.respond_to?(:requested_at)
    assert url.respond_to?(:user_agent_devices)
  end

  def test_the_find_specific_url
    setup_for_url

    assert_instance_of Url, Url.find_specific_url("/blog")
  end

  def test_max_response_time_for_url
    setup_for_url
    url = Url.find_specific_url("/blog")

    assert_equal 100, url.max_response_time_for_url
  end

  def test_min_response_time_for_url
    setup_for_url
    url = Url.find_specific_url("/blog")

    assert_equal 0, url.min_response_time_for_url
  end

  def test_response_time_list_for_url
    setup_for_url
    url = Url.find_specific_url("/blog")

    assert_equal [100, 100, 100, 50, 50, 0], url.response_time_list_for_url
  end

  def test_average_response_time_for_url
    setup_for_url
    url = Url.find_specific_url("/blog")

    assert_equal 66, url.average_response_time_for_url
  end

  def test_finds_verbs_associated_with_url
    setup_for_url
    url = Url.find_specific_url("/blog")

    assert_equal ["GET", "PUT", "DELETE", "POST"], url.verb_list_for_url
  end

  def test_top_referrers_for_url
    setup_for_url
    url = Url.find_specific_url("/blog")

    expected = ["http://turing.io", "http://jumpstartlab.com", "https://google.com"]
    assert_equal expected, url.top_referrers_for_url
    assert_equal 6, PayloadRequest.all.distinct.count
  end

  def test_top_user_agents_for_url
    setup_for_url
    url = Url.find_specific_url("/blog")

    expected = ["Browser: Mac_daddy, OS: Firefox", "Browser: Mac, OS: Safari", "Browser: Macintosh, OS: Chrome"]
    assert_equal expected, url.top_user_agents_for_url
  end
end
