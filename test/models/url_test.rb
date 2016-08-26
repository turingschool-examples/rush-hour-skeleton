require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_validates_url
    url = Url.create(url: "www.google.com")

    assert Url.all.first.valid?
    assert_equal 1, Url.all.count
  end

  def test_it_returns_max_response_time_for_specific_url
    url = Url.create(url: "www.jumpstartlabs.com")

    payload1 = PayloadRequest.create(url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            )
    payload2 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 50,
                referred_by_id: 1,
                request_type_id: 2,
                u_agent_id: 3,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                  )
    payload3 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 12,
                referred_by_id: 1,
                request_type_id: 2,
                u_agent_id: 3,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                            )
    #payload4 has a different url_id
    payload4 = PayloadRequest.create(url_id: 2,
                 requested_at: "date",
                 responded_in: 12,
                 referred_by_id: 1,
                 request_type_id: 2,
                 u_agent_id: 3,
                 resolution_id: 6,
                 ip_id: 2,
                 client_id: 1
                                    )

    # url_1 = PayloadRequest.where(url_id: 1)

    assert_equal 50, url.maximum_response_time
    assert_equal 3, url.payload_requests.count
  end

  def test_it_returns_minimum_response_time_for_specific_url
    url = Url.create(url: "www.jumpstartlabs.com")

    payload1 = PayloadRequest.create(url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            )
    payload2 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 50,
                referred_by_id: 1,
                request_type_id: 2,
                u_agent_id: 3,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                  )
    payload3 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 12,
                referred_by_id: 1,
                request_type_id: 2,
                u_agent_id: 3,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                            )
    #payload4 has a different url_id
    payload4 = PayloadRequest.create(url_id: 2,
                 requested_at: "date",
                 responded_in: 12,
                 referred_by_id: 1,
                 request_type_id: 2,
                 u_agent_id: 3,
                 resolution_id: 6,
                 ip_id: 2,
                 client_id: 1
                              )

    # url_1 = PayloadRequest.where(url_id: 1)

    assert_equal 12, url.minimum_response_time
    assert_equal 3, url.payload_requests.count
  end

  def test_it_orders_all_response_times_per_url
    url = Url.create(url: "www.jumpstartlabs.com")

    payload1 = PayloadRequest.create(url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            )
    payload2 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 50,
                referred_by_id: 1,
                request_type_id: 2,
                u_agent_id: 3,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                  )
    payload3 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 12,
                referred_by_id: 1,
                request_type_id: 2,
                u_agent_id: 3,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                            )

    assert_equal [50, 34, 12], url.response_times_by_order
    refute_equal [12, 34, 50], url.response_times_by_order
  end

  def test_average_response_time
    url = Url.create(url: "www.jumpstartlabs.com")

    payload1 = PayloadRequest.create(url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            )
    payload2 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 50,
                referred_by_id: 1,
                request_type_id: 2,
                u_agent_id: 3,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                  )
    payload3 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 12,
                referred_by_id: 1,
                request_type_id: 2,
                u_agent_id: 3,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                            )

    assert_equal 32, url.average_response_time
    refute_equal 5000, url.average_response_time
  end

  def test_returns_all_request_types
    url = Url.create(url: "www.jumpstartlabs.com")

    payload1 = PayloadRequest.create(url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            )
    payload2 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 50,
                referred_by_id: 1,
                request_type_id: 1,
                u_agent_id: 3,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                  )
    payload3 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 12,
                referred_by_id: 1,
                request_type_id: 1,
                u_agent_id: 3,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                            )
    payload4 = PayloadRequest.create(url_id: 2,
                requested_at: "date",
                responded_in: 12,
                referred_by_id: 1,
                request_type_id: 1,
                u_agent_id: 3,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                )

    request_type1 = RequestType.create(verb: "GET")

    request_type2 = RequestType.create(verb: "POST")

    assert_equal 3, url.request_types.count
    assert_instance_of RequestType, url.request_types.first
  end

  def test_it_returns_top_3_referrers
    url = Url.create(url: "www.jumpstartlabs.com")

    payload1 = PayloadRequest.create(url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            )
    payload2 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 50,
                referred_by_id: 1,
                request_type_id: 1,
                u_agent_id: 3,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                  )
    payload3 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 12,
                referred_by_id: 1,
                request_type_id: 1,
                u_agent_id: 3,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                            )
    payload4 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 12,
                referred_by_id: 2,
                request_type_id: 1,
                u_agent_id: 3,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                )

    payload5 = PayloadRequest.create(url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 2,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            )
    payload6 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 50,
                referred_by_id: 2,
                request_type_id: 1,
                u_agent_id: 3,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                  )
    payload7 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 12,
                referred_by_id: 3,
                request_type_id: 1,
                u_agent_id: 3,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                            )
    payload8 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 12,
                referred_by_id: 4,
                request_type_id: 1,
                u_agent_id: 3,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                )

    referred_by1 = ReferredBy.create(url: "http://jumpstartlabs.com")
    referred_by2 = ReferredBy.create(url: "http://google.com")
    referred_by3 = ReferredBy.create(url: "http://orangebloods.com")
    referred_by4 = ReferredBy.create(url: "http://facebook.com")

    assert_equal referred_by1, url.top_three_referred_bies[0]
    assert_equal referred_by2, url.top_three_referred_bies[1]
    assert_equal referred_by3, url.top_three_referred_bies[2]
    assert_equal 3, url.top_three_referred_bies.count

  end

  def test_it_returns_top_3_u_agents
    url = Url.create(url: "www.jumpstartlabs.com")

    payload1 = PayloadRequest.create(url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            )
    payload2 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 50,
                referred_by_id: 1,
                request_type_id: 1,
                u_agent_id: 4,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                  )
    payload3 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 12,
                referred_by_id: 1,
                request_type_id: 1,
                u_agent_id: 3,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                            )
    payload4 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 12,
                referred_by_id: 2,
                request_type_id: 1,
                u_agent_id: 3,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                )

    payload5 = PayloadRequest.create(url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 2,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            )
    payload6 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 50,
                referred_by_id: 2,
                request_type_id: 1,
                u_agent_id: 2,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                  )
    payload7 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 12,
                referred_by_id: 3,
                request_type_id: 1,
                u_agent_id: 2,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                            )
    payload8 = PayloadRequest.create(url_id: 1,
                requested_at: "date",
                responded_in: 12,
                referred_by_id: 4,
                request_type_id: 1,
                u_agent_id: 1,
                resolution_id: 6,
                ip_id: 2,
                client_id: 1
                )

    u_agent_1 = UAgent.create(agent: "Mozilla/5.0 (Linux; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
    u_agent_2 = UAgent.create(agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
    u_agent_3 = UAgent.create(agent: "Mozilla/5.0 (Apple; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
    u_agent_4 = UAgent.create(agent: "Mozilla/5.0 (Ubuntu; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")

    assert_equal u_agent_3, url.top_three_u_agents[0]
    assert_equal u_agent_2, url.top_three_u_agents[1]
    assert_equal 3, url.top_three_u_agents.count

  end
end
