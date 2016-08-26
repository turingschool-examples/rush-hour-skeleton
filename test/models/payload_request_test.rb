require_relative "../test_helper"

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def create_payload
    # NOTE: The payload below has the column types reformatted already
    payload = '{
      "url":"http://jumpstartlab.com/blog",
      "requested_at":"2013-02-16 21:38:28 -0700",
      "responded_in":37,
      "referred_by":"http://jumpstartlab.com",
      "request_type":"GET",
      "u_agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolution_width":"1920",
      "resolution_height":"1280",
      "ip":"63.29.38.211"
    }'
  end

  def test_it_validates_for_all_fields
    # parsed_payload = JSON.parse(create_payload)
    payload = { url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            }

    # refute PayloadRequest.new(url_id: 1).valid?
    assert PayloadRequest.create(payload).valid?
  end

  def test_it_fails_if_not_all_field_filled
    payload = {url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              client_id: 1

            }

    refute PayloadRequest.create(payload).valid?
  end

  def test_it_returns_average_response_time_across_all_payloads
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            })
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 36,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            })

    assert_equal 35, PayloadRequest.average_response_time
    assert_equal 2, PayloadRequest.all.count
  end

  def test_it_returns_max_response_time_across_all_payloads
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            })
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 36,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            })

    assert_equal 36, PayloadRequest.max_response_time
    assert_equal 2, PayloadRequest.all.count
  end

  def test_it_returns_min_response_time_across_all_payloads
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            })
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 36,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            })

    assert_equal 34, PayloadRequest.min_response_time
    assert_equal 2, PayloadRequest.all.count
  end

  def test_it_returns_most_frequent_request_type
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 1,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            })
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 36,
              referred_by_id: 1,
              request_type_id: 1,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            })
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 36,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            })
    request_type1 = RequestType.create(verb: "GET")
    request_type2 = RequestType.create(verb: "POST")

    assert_equal request_type1, PayloadRequest.most_requested_type
    refute_equal request_type2, PayloadRequest.most_requested_type
  end

  def test_it_returns_all_HTTP_types_used
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 1,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            })
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 36,
              referred_by_id: 1,
              request_type_id: 1,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            })
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 36,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            })
    request_type1 = RequestType.create(verb: "GET")
    request_type2 = RequestType.create(verb: "POST")

    assert_equal 3, PayloadRequest.all_http_verbs_used.count
    assert_instance_of RequestType, PayloadRequest.all_http_verbs_used.first
  end

  def test_it_returns_most_requested_urls
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 1,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            })
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 36,
              referred_by_id: 1,
              request_type_id: 1,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            })
    PayloadRequest.create({ url_id: 2,
              requested_at: "date",
              responded_in: 36,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            })
    url1 = Url.create(url: "www.jumpstartlab.com")
    url2 = Url.create(url: "www.google.com")

    assert_instance_of Url, PayloadRequest.most_requested_urls.first
    assert_equal 2, PayloadRequest.most_requested_urls.count
    assert_equal url1, PayloadRequest.most_requested_urls[0]
  end

  def test_it_returns_collection_of_all_uagents_across_all_requests
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 1,
              u_agent_id: 1,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            })
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 36,
              referred_by_id: 1,
              request_type_id: 1,
              u_agent_id: 2,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            })
    PayloadRequest.create({ url_id: 2,
              requested_at: "date",
              responded_in: 36,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 2,
              resolution_id: 6,
              ip_id: 2,
              client_id: 1
            })
    u_agent1 = UAgent.create(agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
    u_agent2 = UAgent.create(agent: "Mozilla/5.0 (Linux; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")

    assert_instance_of UAgent, PayloadRequest.all_u_agents.first
    assert_equal 3, PayloadRequest.all_u_agents.count
  end

  def test_it_returns_collection_of_all_uagents_across_all_requests
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 1,
              u_agent_id: 1,
              resolution_id: 1,
              ip_id: 2,
              client_id: 1
            })
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 36,
              referred_by_id: 1,
              request_type_id: 1,
              u_agent_id: 2,
              resolution_id: 2,
              ip_id: 2,
              client_id: 1
            })
    PayloadRequest.create({ url_id: 2,
              requested_at: "date",
              responded_in: 36,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 2,
              resolution_id: 2,
              ip_id: 2,
              client_id: 1
            })
    resolution1 = Resolution.create(height: 1920, width: 1200)
    resolution2 = Resolution.create(height: 2300, width: 1200)


    assert_instance_of Resolution, PayloadRequest.all_screen_resolutions.first
    assert_equal 3, PayloadRequest.all_screen_resolutions.count
  end



  # def test_it_returns_web_browser_breakdown_across_all_requests
  #   PayloadRequest.create({ url_id: 1,
  #             requested_at: "date",
  #             responded_in: 34,
  #             referred_by_id: 1,
  #             request_type_id: 1,
  #             u_agent_id: 1,
  #             resolution_id: 6,
  #             ip_id: 2
  #           })
  #   PayloadRequest.create({ url_id: 1,
  #             requested_at: "date",
  #             responded_in: 36,
  #             referred_by_id: 1,
  #             request_type_id: 1,
  #             u_agent_id: 2,
  #             resolution_id: 6,
  #             ip_id: 2
  #           })
  #   PayloadRequest.create({ url_id: 2,
  #             requested_at: "date",
  #             responded_in: 36,
  #             referred_by_id: 1,
  #             request_type_id: 2,
  #             u_agent_id: 2,
  #             resolution_id: 6,
  #             ip_id: 2
  #           })
  #   u_agent1 = UAgent.create(agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
  #   u_agent2 = UAgent.create(agent: "Mozilla/5.0 (Linux; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
  #
  #   expected = {"Chrome" => 2}
  #   assert_equal expected, PayloadRequest.browser_breakdown
  #   assert_equal 3, PayloadRequest.all_u_agents.count
  # end


end
