require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_url_instance
    url = create_url
    address = "http://jumpstartlab.com/blog"

    assert_equal address, url.address
    refute_nil url.referral_id
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
    url = Url.new(referral_id: 1)

    refute url.valid?
  end

  def test_it_cannot_create_url_without_referral_id
    url = Url.new(address: "www.google.com")

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
    skip
    create_faker_payloads(30)

    url = Url.first

    assert_equal "www.", Url.sample
  end

end
