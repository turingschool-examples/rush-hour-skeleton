require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelper

  def test_it_can_save_a_url
    Url.create(root_url: "www.jumpstartlabs.com",
                   path: "/example")

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
    url = Url.create(root_url: "www.jumpstartlabs.com",
                   path: "/example")

    assert_equal "www.jumpstartlabs.com/example", url.full_path
  end

  def test_it_returns_the_maximum_response_time_for_a_specific_url
    url1 = Url.create(root_url: "www.jumpstartlabs.com",
                          path: "/blog")

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 100,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 200,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    assert_equal 200, Url.max_response_time("www.jumpstartlabs.com")
  end

  def test_it_returns_the_minimum_response_time_for_a_specific_url
    url1 = Url.create(root_url: "www.jumpstartlabs.com",
                          path: "/blog")

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 100,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 200,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    assert_equal 100, Url.min_response_time("www.jumpstartlabs.com")
  end

  def test_it_returns_the_average_response_time_for_a_specific_url
    url1 = Url.create(root_url: "www.jumpstartlabs.com",
                          path: "/blog")

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 100,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 200,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    assert_equal 150, Url.average_response_time("www.jumpstartlabs.com")
  end

  def test_it_returns_list_of_all_response_times_from_longest_to_shortest
    url1 = Url.create(root_url: "www.jumpstartlabs.com",
                          path: "/blog")

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 100,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 200,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    assert_equal [200, 100], Url.all_response_times("www.jumpstartlabs.com")
  end

  def test_it_returns_verbs_requested_for_a_specific_url
    verb1 = RequestType.create(verb: "GET")
    verb2 = RequestType.create(verb: "POST")

    url1 = Url.create(root_url: "www.jumpstartlabs.com",
                          path: "/blog")

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 100,
                     referral_id: 1,
                 request_type_id: verb1.id,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 200,
                     referral_id: 1,
                 request_type_id: verb2.id,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    assert Url.find_verbs_for_a_url("www.jumpstartlabs.com").include?("GET")
    assert Url.find_verbs_for_a_url("www.jumpstartlabs.com").include?("POST")
  end

  def test_it_returns_top_three_referrers
    url1 = Url.create(root_url: "www.jumpstartlabs.com",
                          path: "/blog")

    turing = Referral.create(root_url: "www.turing.io",
                                 path: "/today")
    google = Referral.create(root_url: "www.google.com",
                                 path: "/today")
    zomble = Referral.create(root_url: "www.zomble.com",
                                 path: "/today")
    poop   = Referral.create(root_url: "www.poop.org",
                                 path: "/today")

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 100,
                     referral_id: turing.id,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 200,
                     referral_id: turing.id,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

     PayloadRequest.create(url_id: url1.id,
                     requested_at: "2013-02-16 21:38:28 -0700",
                    response_time: 200,
                      referral_id: google.id,
                  request_type_id: 1,
                         event_id: 1,
                    user_agent_id: 1,
                    resolution_id: 1,
                            ip_id: 1,
                        client_id: 1)

      PayloadRequest.create(url_id: url1.id,
                      requested_at: "2013-02-16 21:38:28 -0700",
                     response_time: 200,
                       referral_id: google.id,
                   request_type_id: 1,
                          event_id: 1,
                     user_agent_id: 1,
                     resolution_id: 1,
                             ip_id: 1,
                         client_id: 1)

     PayloadRequest.create(url_id: url1.id,
                     requested_at: "2013-02-16 21:38:28 -0700",
                    response_time: 200,
                      referral_id: zomble.id,
                  request_type_id: 1,
                         event_id: 1,
                    user_agent_id: 1,
                    resolution_id: 1,
                            ip_id: 1,
                        client_id: 1)

      PayloadRequest.create(url_id: url1.id,
                      requested_at: "2013-02-16 21:38:28 -0700",
                     response_time: 200,
                       referral_id: zomble.id,
                   request_type_id: 1,
                          event_id: 1,
                     user_agent_id: 1,
                     resolution_id: 1,
                             ip_id: 1,
                         client_id: 1)


       PayloadRequest.create(url_id: url1.id,
                       requested_at: "2013-02-16 21:38:28 -0700",
                      response_time: 200,
                        referral_id: poop.id,
                    request_type_id: 1,
                           event_id: 1,
                      user_agent_id: 1,
                      resolution_id: 1,
                              ip_id: 1,
                          client_id: 1)

    assert Url.top_referrers("www.jumpstartlabs.com").include?("www.zomble.com/today")
    assert Url.top_referrers("www.jumpstartlabs.com").include?("www.turing.io/today")
    assert Url.top_referrers("www.jumpstartlabs.com").include?("www.google.com/today")
  end

  def test_it_returns_top_three_user_agents
    url1 = Url.create(root_url: "www.jumpstartlabs.com",
                          path: "/blog")

    chrome_apple  = UserAgent.create(browser: "Chrome 24.0.1309",
                                          os: "Mac OS X 10.8.2")
    ie_apple      = UserAgent.create(browser: "IE 9.0",
                                          os: "Mac OS X 10.8.2")
    firefox_apple = UserAgent.create(browser: "Firefox 30.0.1",
                                          os: "Mac OS X 10.8.2")
    opera_apple   = UserAgent.create(browser: "Opera 2.7",
                                          os: "Mac OS X 10.8.2")


    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 100,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: chrome_apple.id,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 200,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: chrome_apple.id,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 200,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: ie_apple.id,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 200,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: ie_apple.id,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 200,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: firefox_apple.id,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 200,
                     referral_id: 1 ,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: firefox_apple.id,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 200,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: opera_apple.id,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

   assert Url.top_user_agents("www.jumpstartlabs.com").include?("IE 9.0 Mac OS X 10.8.2")
   assert Url.top_user_agents("www.jumpstartlabs.com").include?("Firefox 30.0.1 Mac OS X 10.8.2")
   assert Url.top_user_agents("www.jumpstartlabs.com").include?("Chrome 24.0.1309 Mac OS X 10.8.2")
  end


end
