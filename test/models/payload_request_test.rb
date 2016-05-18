require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test

  def test_payload_without_info_is_not_valid
    refute PayloadRequest.create(url: "http://jumpstartlab.com/blog").valid?
  end

  def setup
    PayloadRequest.create(url: "twitter.com", requested_at: "2013-02-16 21:38:28 -0700", responded_in: 10, referred_by: "facebook.com", request_type: "GET", parameters_id: 1, event_name: "search", user_agent_id: 1, resolution_id: 1, ip_id: 1)
    PayloadRequest.create(url: "enewsonline.com", requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by: "facebook.com", request_type: "GET", parameters_id: 1, event_name: "search", user_agent_id: 1, resolution_id: 1, ip_id: 1)
  end

  def test_it_averages_response_times
    assert_equal 15, PayloadRequest.average_response_time
  end

  def test_it_finds_max_response_time
    assert_equal 20, PayloadRequest.max_response_time
  end

  def test_it_finds_min_response_time
    assert_equal 10, PayloadRequest.min_response_time
  end

  def test_it_finds_all_verbs_without_repeating_itself
    assert_equal ["GET"], PayloadRequest.all_http_verbs
  end

  def test_it_sorts_urls_by_fequency
    skip
    #need to figure out incrementation
    assert_equal ({"twitter.com" => 100}), PayloadRequest.list_urls_in_frequency
  end

end
