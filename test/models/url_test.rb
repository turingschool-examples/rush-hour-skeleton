require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert Url
  end

  def test_can_create_url_addresses
    url_address = {address: "http://jumpstartlab.com"}
    url = Url.create(url_address)

    assert_equal "http://jumpstartlab.com", url.address
    assert_equal 1, url.id
  end

  def test_can_return_specific_url_max_response_time
    create_payload_4
    create_payload_5
    create_payload_6

    url = Url.find(1)
    assert_equal 40, url.max_response_time
  end

  def test_can_return_specific_url_min_response_time
    create_payload_4
    create_payload_5
    create_payload_6

    url = Url.find(1)
    assert_equal 30, url.min_response_time
  end

  def test_returns_all_response_times_from_longest_to_shortest_for_specific_url
    create_payload_4
    create_payload_5
    create_payload_6

    url = Url.find(1)
    expected = [40, 30]
    assert_equal expected, url.all_response_times
  end

  def test_can_return_average_response_for_specific_url
    create_payload_4
    create_payload_5
    create_payload_6

    url = Url.find(1)
    assert_equal 35, url.average_response_time
  end

  def test_returns_http_verbs_for_specific_url
    create_payload_4
    create_payload_5
    create_payload_6

    url = Url.find(1)
    assert_equal ["GET", "POST"], url.all_http_verbs.sort
  end

  def test_returns_three_most_popular_referrers_for_specific_url
    create_payload_4
    create_payload_5
    create_payload_6
    create_payload_4
    create_payload_5
    create_payload_6
    create_payload_7
    create_payload_8
    create_payload_8

    expected = ["http://google.com", "http://jumpstartlab.com", "http://yahoo.com"]
    url = Url.find(1)
    assert_equal expected, url.top_three_referrers.sort
  end

  def test_returns_three_most_popular_user_systems_for_specific_url
    create_payload_1
    create_payload_3
    create_payload_8
    create_payload_8
    create_payload_8
    create_payload_8
    create_payload_4
    create_payload_4
    create_payload_5
    create_payload_5
    create_payload_5

    expected = [["Safari", "Windows"], ["Firefox", "Windows"], ["Chrome", "Mac OSX"]]
    url = Url.find(2)

    assert_equal expected, url.top_three_user_systems
  end
end
