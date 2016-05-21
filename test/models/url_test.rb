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

  def test_it_can_return_the_three_top_referred_bies
  url1 = Url.create({address: "turing.io"})
   ReferredBy.create({ name: "Super popular!"})
   ReferredBy.create({ name: "Not popular!"})
   ReferredBy.create({ name: "Moderately popular!"})
   ReferredBy.create({ name: "Super not popular!"})
   payload1 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 1, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
   payload2 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 1, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
   payload3= PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 1, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
   payload4=PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
   payload5= PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 4, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
   payload6= PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 1, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
   assert_equal ["Super popular!", "Moderately popular!", "Super not popular!"], url1.three_most_popular_referrers
 end

 def test_find_top_three_user_agents_for_single_url
   url1 = Url.create({address: "turing.io"})
   user_agent1 = UserAgentInfo.create({ browser: "IE", version: "Version!", platform: "Platform!", os: "Windows 10"})
   user_agent2 = UserAgentInfo.create({ browser: "Chrome", version: "Version!", platform: "Platform!", os: "Mac OS X"})
   user_agent3 = UserAgentInfo.create({ browser: "Firefox", version: "Version!", platform: "Platform!", os: "Ubuntu"})
   payload1 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 1, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
   payload2 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 1, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
   payload3 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 1, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
   payload4 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 1, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 2, screen_size_id: 1, ip_id: 1})
   payload5 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 1, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 2, screen_size_id: 1, ip_id: 1})
   payload6 = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 1, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 3, screen_size_id: 1, ip_id: 1})

   assert_equal ["OS: Windows 10, Browser: IE", "OS: Mac OS X, Browser: Chrome", "OS: Ubuntu, Browser: Firefox"], url1.three_most_popular_user_agents
 end
end
