require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_url
    url = Url.create(address:"Turing.io")
    assert_equal "Turing.io", url.address
  end

  def test_doesnt_create_if_missing_field
    Url.create
    assert_equal 0, Url.count
  end

  def test_for_relationship_with_payload_request
    create_payload(1)
    payload= PayloadRequest.find(1)
    assert_equal "http://jumpstartlab.com/blog0", payload.url.address
  end

  def test_urls_from_most_requested_to_least_requested
    create_payload(1)
    create_payload2(2)
    create_payload3(1)

    expected = ["http://turing.io/blog", "http://galvanize.com/blog", "http://jumpstartlab.com/blog0"]
    assert_equal expected, Url.urls_from_most_to_least_requested
  end

  def test_max_response_time_for_urls
    create_payload3(3)

    assert_equal 10, Url.first.max_response_time_for_url
  end

  def test_min_response_time_for_urls
    create_payload(3)

    assert_equal 0, Url.first.min_response_time_for_url
  end

  def test_average_response_time_for_url
    create_payload3(3)

    assert_equal 10, Url.first.average_response_time_for_url
  end

  def test_response_times_across_requests_for_urls
    create_payload5(3)

    assert_equal [52, 51, 50], Url.first.list_of_response_times_across_requests_for_urls
  end

  def test_http_verbs_used_for_urls
    create_payload3(3)

    assert_equal ["POST", "POST", "POST"], Url.first.http_verbs_used_for_urls
  end

  def test_three_most_popular_referrers
    create_payload5(5)

    expected = ["http://robohash.com0", "http://robohash.com1", "http://robohash.com2"]
    assert_equal expected, Url.first.three_most_popular_referrers
  end

  def test_three_most_popular_software_agents
    create_payload5(5)

    expected = ["OSX 10.11.50 Chrome0", "OSX 10.11.51 Chrome1", "OSX 10.11.52 Chrome2"]
    assert_equal expected, Url.first.three_most_popular_software_agents
  end
end
