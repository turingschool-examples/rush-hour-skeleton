require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers


  def test_it_can_accept_pr
    pr = PayloadRequest.create(url: Url.create(address: "http://jumpstartlab.com"),
                               referrer: Referrer.create(address: "http://amazon.com"),
                               request_type: RequestType.create(verb: "GET"),
                               event: Event.create(name: "socialLogin"),
                               user_agent: UserAgent.create(browser: "Chrome", platform: "Macintosh"),
                               resolution: Resolution.create(width: "1920", height: "1280"),
                               ip: Ip.create(address: "63.29.38.211"),
                               requested_at: "2013-02-16 21:38:28 -0700",
                               responded_in: 37
                              )

    assert_equal "http://jumpstartlab.com", pr.url.address
    assert_equal "http://amazon.com", pr.referrer.address
    assert_equal "GET", pr.request_type.verb
    assert_equal "socialLogin", pr.event.name
    assert_equal "Chrome", pr.user_agent.browser
    assert_equal "Macintosh", pr.user_agent.platform
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
                               user_agent: UserAgent.create(browser: nil, platform: nil),
                               resolution: Resolution.create(width: nil, height: nil),
                               ip: Ip.create(address: nil),
                               requested_at: nil,
                               responded_in: nil
                              )


    assert_nil pr.url.address
    assert_nil pr.referrer.address
    assert_nil pr.request_type.verb
    assert_nil pr.event.name
    assert_nil pr.user_agent.browser
    assert_nil pr.user_agent.platform
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

  def test_it_returns_max_response_time_given_specific_url
    setup_data
    url_address = "http://jumpstartlab.com"

    assert_equal 40, PayloadRequest.max_response_time_by_url(url_address)
  end

  def test_it_returns_min_response_time_given_specific_url
    setup_data
    url_address = "http://jumpstartlab.com"

    assert_equal 20, PayloadRequest.min_response_time_by_url(url_address)
  end

  def test_list_response_time_given_specific_url_from_longest
    setup_data
    url_address = "http://jumpstartlab.com"

    assert_equal [40, 20], PayloadRequest.all_response_time_by_url(url_address)
  end

  def test_average_response_time_given_specific_url
    setup_data
    url_address = "http://jumpstartlab.com"

    assert_equal 30, PayloadRequest.average_response_time_by_url(url_address)
  end

  def test_list_http_verbs_given_specific_url
    setup_data
    url_address = "http://jumpstartlab.com"

    assert_equal ["GET", "POST"], PayloadRequest.list_http_verbs_by_url(url_address)
  end

  def test_list_http_verbs_given_specific_url

    PayloadRequest.create(referrer: Referrer.create(address:"http://newegg.com"))
    PayloadRequest.create(referrer: Referrer.create(address:"http://newegg.com"))
    PayloadRequest.create(referrer: Referrer.create(address:"http://amazon.com"))
    PayloadRequest.create(referrer: Referrer.create(address:"http://amazon.com"))
    PayloadRequest.create(referrer: Referrer.create(address:"http://amazon.com"))
    PayloadRequest.create(referrer: Referrer.create(address:"http://amazon.com"))

    url_address = "http://jumpstartlab.com"

    assert_equal nil, PayloadRequest.top_three_referrers_by_url(url_address)
  end
end

