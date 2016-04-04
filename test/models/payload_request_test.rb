require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers


  def test_it_can_accept_pr
    pr = PayloadRequest.create(url: Url.create(address: "http://jumpstartlab.com"),
                               referrer: Referrer.create(address: "http://amazon.com"),
                               request_type: RequestType.create(verb: "GET"),
                               event: Event.create(name: "socialLogin"),
                               u_agent: UAgent.create(browser: "Chrome", platform: "Macintosh"),
                               resolution: Resolution.create(width: "1920", height: "1280"),
                               ip: Ip.create(address: "63.29.38.211"),
                               requested_at: "2013-02-16 21:38:28 -0700",
                               responded_in: 37
                              )

    assert_equal "http://jumpstartlab.com", pr.url.address
    assert_equal "http://amazon.com", pr.referrer.address
    assert_equal "GET", pr.request_type.verb
    assert_equal "socialLogin", pr.event.name
    assert_equal "Chrome", pr.u_agent.browser
    assert_equal "Macintosh", pr.u_agent.platform
    assert_equal "1920", pr.resolution.width
    assert_equal "1280", pr.resolution.height
    assert_equal "63.29.38.211", pr.ip.address
    assert_equal "2013-02-16 21:38:28 -0700", pr.requested_at
    assert_equal 37, pr.responded_in
  end

  def test_it_checks_for_empty_address
    pr = PayloadRequest.create(url: Url.create(address: nil),
                               referrer: Referrer.create(address: nil),
                               request_type: RequestType.create(verb: nil),
                               event: Event.create(name: nil),
                               u_agent: UAgent.create(browser: nil, platform: nil),
                               resolution: Resolution.create(width: nil, height: nil),
                               ip: Ip.create(address: nil),
                               requested_at: nil,
                               responded_in: nil
                              )


    assert_nil pr.url.address
    assert_nil pr.referrer.address
    assert_nil pr.request_type.verb
    assert_nil pr.event.name
    assert_nil pr.u_agent.browser
    assert_nil pr.u_agent.platform
    assert_nil pr.resolution.width
    assert_nil pr.resolution.height
    assert_nil pr.ip.address
    assert_nil pr.requested_at
    assert_nil pr.responded_in
  end

  def test_it_returns_average_response_time
    setup_data

    assert_equal 30, PayloadRequest.average_response_time
  end

  def test_it_returns_max_response_time
    setup_data

    assert_equal 40, PayloadRequest.max_response_time
  end

  def test_it_returns_min_response_time
    setup_data

    assert_equal 20, PayloadRequest.min_response_time
  end

  def test_it_references_a_client
    pr = PayloadRequest.create(url: Url.find_or_create_by(address: "http://jonliss.com"),
                               referrer: Referrer.create(address: "http://amazon.com"),
                               request_type: RequestType.find_or_create_by(verb: "GET"),
                               event: Event.create(name: "socialLogin"),
                               u_agent: UAgent.create(browser: "Chrome", platform: "Macintosh"),
                               resolution: Resolution.create(width: "1920", height: "1280"),
                               ip: Ip.create(address: "63.29.38.211"),
                               requested_at: "2013-02-16 21:38:28 -0700",
                               responded_in: 37,
                               client: Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com" )
                              )

    assert_equal "jumpstartlab", pr.client.identifier
    assert_equal "http://jumpstartlab.com", pr.client.root_url

  end

  def test_most_frequent_request_type
    setup_data

    assert_equal "GET", PayloadRequest.most_frequent_request_type
  end

  def test_event_list_from_most_to_least
    setup_data
    expected = {"facebook"=>2, "twitter"=>1}

    assert_equal expected, PayloadRequest.event_list_from_most_to_least
  end

  def test_urls_list_from_most_to_least_requested
    setup_data
    expected =  {"http://jumpstartlab.com"=>2, "http://turing.io"=>1}

    assert_equal expected, PayloadRequest.urls_list_from_most_to_least_requested
  end
end
