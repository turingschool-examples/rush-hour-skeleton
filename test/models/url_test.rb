require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_url_instance
    url = create_url
    address = "http://jumpstartlab.com/blog"

    assert_equal address, url.address
  end

  def test_url_relationship_to_payload_requests
    create_payload(1)
    url = Url.first
    url.payload_requests << PayloadRequest.all.first

    refute url.payload_requests.empty?
    url.payload_requests.exists?(url.id)
    assert_equal 1, url.payload_requests.size
  end

  def test_it_cannot_create_url_without_address
    url = Url.new(address: "")

    refute url.valid?
  end

  def test_url_response_times
    three_relationship_requests

    url = Url.first

    assert_equal [37, 28], url.all_response_times
  end

  def test_average_response_time_for_url
    three_relationship_requests

    url = Url.first

    assert_equal 32, url.average_response_time
  end

  def test_verbs_used_for_url
    three_relationship_requests

    url = Url.first

    assert_equal ["GET", "POST"], url.all_verbs
  end

  def test_most_popular_referrers
    three_relationship_requests
    five_more_pr_for_referral_test

    url = Url.first
    expected = ["www.facebook.com", "wwww.google.com", "wwww.theonion.com"]
    
    assert_equal expected, url.most_popular_referrers.sort
  end

  def test_three_most_popular_user_agents
    three_relationship_requests
    five_more_pr_for_referral_test

    url = Url.first

    expected = ["Mozilla/5.0 (Macintosh; Windows XP) AppleWebKit/537.17 (KHTML, like Gecko) Firefox/24.0.1309.0 Safari/537.17", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Safari/24.0.1309.0 Safari/537.17", "Mozilla/5.0 (Macintosh; iOs) AppleWebKit/537.17 (KHTML, like Gecko) Safari/24.0.1309.0 Safari/537.17"]

    assert_equal expected, url.most_popular_user_agents
  end

end
