require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelper

  def test_it_can_save_a_url
    create_url

    url = Url.first

    assert_equal "www.jumpstartlabs.com", url.root_url
    assert_equal "/example", url.path
  end

  def test_it_doesnt_save_url_with_invalid_path
    Url.create(root_url: "www.jumpstartlabs.com")

    assert_equal [], Url.all.to_a
  end

  def test_it_doesnt_save_url_with_invalid_root_url
    Url.create(path: "/example")

    assert_equal [], Url.all.to_a
  end

  def test_it_returns_the_full_path_url
    url = create_url

    assert_equal "www.jumpstartlabs.com/example", url.full_path
  end

  def test_it_returns_all_urls_from_most_to_least_requested
    url1 = create_url

    url2 = Url.create(root_url: "www.turing.io",
                      path:     "/blog")

    create_payload_requests_with_two_urls(url1.id, url2.id)
    create_client

    urls = { ["www.jumpstartlabs.com", "/example"] => 2, ["www.turing.io", "/blog"] => 1 }

    assert_equal urls, Client.find(1).urls.most_to_least_requested
  end

  def test_it_returns_the_maximum_response_time_for_a_specific_url
    url = create_url

    create_payload_requests(url.id)

    assert_equal 300, url.max_response_time
  end

  def test_it_returns_the_minimum_response_time_for_a_specific_url
    url = create_url

    create_payload_requests(url.id)

    assert_equal 100, url.min_response_time
  end

  def test_it_returns_the_average_response_time_for_a_specific_url
    url = create_url

    create_payload_requests(url.id)

    assert_equal 200, url.average_response_time
  end

  def test_it_returns_all_response_times_for_a_specific_url
    url = create_url

    create_payload_requests(url.id)

    all_response_times = url.all_response_times

    assert all_response_times.include?(100)
    assert all_response_times.include?(300)
    assert_equal all_response_times.size, 2
  end

  def test_it_can_find_verbs_for_a_specific_url
    url = create_url

    request1 = RequestType.create(verb: "POST")
    request2 = RequestType.create(verb: "GET")

    create_payload_requests(url.id, request1.id, request2.id)

    verbs = url.find_verbs

    assert verbs.include?("GET")
    assert verbs.include?("POST")
    assert_equal 2, verbs.size
  end

  def test_it_returns_top_three_referrers
    url = Url.create(root_url: "www.jumpstartlabs.com",
                          path: "/blog")

    turing = Referral.create(root_url: "www.turing.io",
                                 path: "/today")
    google = Referral.create(root_url: "www.google.com",
                                 path: "/today")
    zomble = Referral.create(root_url: "www.zomble.com",
                                 path: "/today")
    poop   = Referral.create(root_url: "www.poop.org",
                                 path: "/today")

    create_payload_requests_with_referral_id(url.id, turing.id, google.id, zomble.id, poop.id)

    top_referrers = url.top_referrers

    assert_equal 2, top_referrers[["www.zomble.com", "/today"]]
    assert_equal 2, top_referrers[["www.google.com", "/today"]]
    assert_equal 2, top_referrers[["www.turing.io", "/today"]]
    assert_equal 3, top_referrers.size
  end

  def test_it_returns_top_three_user_agents
    url = Url.create(root_url: "www.jumpstartlabs.com",
                          path: "/blog")

    ua1 = UserAgent.create(browser: "Chrome 24.0.1309",
                           os:      "Mac OS X 10.8.2")
    ua2 = UserAgent.create(browser: "IE 9.0",
                           os:      "Windows 7")
    ua3 = UserAgent.create(browser: "Safari 5.2",
                           os:      "Mac OS X 10.8.2")
    ua4 = UserAgent.create(browser: "Opera 1.5",
                           os:      "Windows 10.1")

    create_payload_requests_with_user_agent_id(url.id, ua1.id, ua2.id, ua3.id, ua4.id)

    top_user_agents = url.top_user_agents

    assert_equal 2, top_user_agents[["Chrome 24.0.1309", "Mac OS X 10.8.2"]]
    assert_equal 2, top_user_agents[["IE 9.0", "Windows 7"]]
    assert_equal 2, top_user_agents[["Safari 5.2", "Mac OS X 10.8.2"]]
    assert_equal 3, top_user_agents.size
  end

  def create_url
    Url.create(root_url: "www.jumpstartlabs.com",
               path:     "/example")
  end

  def create_payload_requests(url1_id, request1_id = 1, request2_id = 1)
    PayloadRequest.create(
      url_id:          url1_id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   100,
      referral_id:     1,
      request_type_id: request1_id,
      event_id:        1,
      user_agent_id:   1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1, )
    PayloadRequest.create(
      url_id:          url1_id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   300,
      referral_id:     1,
      request_type_id: request2_id,
      event_id:        1,
      user_agent_id:   1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1 )
  end

  def create_payload_requests_with_referral_id(url_id, id1, id2, id3, id4)
    PayloadRequest.create(
      url_id:          url_id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   200,
      referral_id:     id1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)

    PayloadRequest.create(
      url_id:          url_id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   200,
      referral_id:     id1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)

    PayloadRequest.create(
      url_id:          url_id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   200,
      referral_id:     id2,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)

    PayloadRequest.create(
      url_id:          url_id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   200,
      referral_id:     id2,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)

    PayloadRequest.create(
      url_id:          url_id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   200,
      referral_id:     id3,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)

    PayloadRequest.create(
      url_id:          url_id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   200,
      referral_id:     id3,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)

    PayloadRequest.create(
      url_id:          url_id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   200,
      referral_id:     id4,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)
  end

  def create_payload_requests_with_user_agent_id(url_id, id1, id2, id3, id4)
    PayloadRequest.create(
      url_id:          url_id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   200,
      referral_id:     1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   id1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)

    PayloadRequest.create(
      url_id:          url_id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   200,
      referral_id:     1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   id1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)

    PayloadRequest.create(
      url_id:          url_id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   200,
      referral_id:     1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   id2,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)

    PayloadRequest.create(
      url_id:          url_id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   200,
      referral_id:     1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   id2,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)

    PayloadRequest.create(
      url_id:          url_id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   200,
      referral_id:     1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   id3,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)

    PayloadRequest.create(
      url_id:          url_id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   200,
      referral_id:     1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   id3,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)

    PayloadRequest.create(
      url_id:          url_id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   200,
      referral_id:     1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   id4,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)
  end

  def create_payload_requests_with_two_urls(url1_id, url2_id)
    PayloadRequest.create(
      url_id:          url1_id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   100,
      referral_id:     1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1, )
    PayloadRequest.create(
      url_id:          url1_id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   300,
      referral_id:     1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1 )
    PayloadRequest.create(
      url_id:          url2_id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   100,
      referral_id:     1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1, )
  end
end
