require_relative '../test_helper'

class UrlTest < Minitest::Test

  include TestHelpers

  def test_it_returns_false_when_partial_information_is_entered
    url = Url.new({ })
    refute url.save
  end

  def test_it_returns_true_when_all_information_is_entered
    url = Url.new({ address: "www's!"})
    assert url.save
  end

  def test_it_generates_list_of_urls_by_frequency
    url1 = Url.create({address: "http://www.google.com"})
    url2 = Url.create({address: "http://www.google.com"})
    url3 = Url.create({address: "http://www.nyt.com"})
    url4 = Url.create({address: "http://www.nyt.com"})
    url5 = Url.create({address: "http://www.nyt.com"})
    assert_equal ["http://www.nyt.com", "http://www.google.com"], Url.list_urls_by_frequency
  end

  def test_can_find_max_response_time_for_specific_url
    url1 = Url.create({address: "http://www.google.com"})
    url2 = Url.create({address: "http://www.nyt.com"})
    payload1 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
    payload2 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 30, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
    payload3 = PayloadRequest.create({url_id: 2, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 40, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})

    assert_equal 30, url1.max_response_time
  end

  def test_can_find_min_response_time_for_specific_url
    url1 = Url.create({address: "http://www.google.com"})
    url2 = Url.create({address: "http://www.nyt.com"})
    payload1 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
    payload2 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 30, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
    payload3 = PayloadRequest.create({url_id: 2, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 40, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})

    assert_equal 20, url1.min_response_time
  end

  def test_can_find_avg_response_time_for_specific_url
    url1 = Url.create({address: "http://www.google.com"})
    url2 = Url.create({address: "http://www.nyt.com"})
    payload1 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
    payload2 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 30, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
    payload3 = PayloadRequest.create({url_id: 2, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 40, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})

    assert_equal 25, url1.average_response_time
  end

  def test_can_return_ordered_response_times_for_specific_url
    url1 = Url.create({address: "http://www.google.com"})
    url2 = Url.create({address: "http://www.nyt.com"})
    payload1 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
    payload2 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 30, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
    payload3 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 5, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
    payload3 = PayloadRequest.create({url_id: 2, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 40, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})

    assert_equal [30, 20, 5], url1.all_response_times_sorted
  end

  def test_can_return_request_types_for_specific_url
    url1 = Url.create({address: "http://www.google.com"})
    request_type1 = RequestType.create({name: "GET"})
    request_type2 = RequestType.create({name: "POST"})
    payload1 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
    payload2 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 30, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
    payload3 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 5, referred_by_id: 3, request_type_id: 2, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})

    assert_equal ["GET", "POST"], url1.http_verbs_for_url
  end
end
